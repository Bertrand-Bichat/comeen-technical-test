# frozen_string_literal: true

module Deskq
  module Devices
    class Synchronizer
      attr_reader :device

      def initialize(device)
        @device = device
      end

      def fetch_sync_changes
        referenced_desks_with_changes.values
      end

      def apply_sync_changes!
        referenced_desks_with_changes.values.map(&:save!)
      end

      private

      def referenced_desks_with_changes
        @referenced_desks_with_changes ||= referenced_desks.transform_values do |desk|
          desk.assign_attributes(desk_data[desk.sync_id])
        end
      end

      def referenced_desks
        @referenced_desks ||= Desk.where(sync_id: desk_data.keys).index_by(&:sync_id)
      end

      def desk_data
        @desk_data ||= raw_data.slice(1..-1) # Skip the header row
          .values.to_h do |row|
          [
            row[1],
            {
              name: row[0],
            },
          ]
        end
      end

      def raw_data
        @raw_desk_data ||= sheets_service.get_sheet(device.google_sheet_id, "A1:Z")
      end

      def sheets_service
        @sheet_service ||= Google::Sheets::SheetsService.new(device.google_sheet_id)
      end
    end
  end
end
