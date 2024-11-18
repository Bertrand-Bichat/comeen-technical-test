# frozen_string_literal: true

require_dependency "deskq"

module Deskq
  class Device < ApplicationRecord
    COLORS = ["RED", "GREEN"].freeze

    belongs_to :desk

    validates :api_id, presence: true, uniqueness: true
    validates :color, presence: true, inclusion: { in: COLORS }
    validates :desk_sync_id, presence: true

    def new_color
      color == "RED" ? "GREEN" : "RED"
    end

    def available?
      color == "GREEN"
    end

    def occupied?
      color == "RED"
    end

    def mark_as_available!
      return if available?

      Deskq::Devices::DevicesService.new.change_color(id, "GREEN")
    end

    def mark_as_occupied!
      return if occupied?

      Deskq::Devices::DevicesService.new.change_color(id, "RED")
    end

    class << self
      def fetch_all_devices
        FetchAllDeskqDevicesJob.perform_later
      end
    end
  end
end
