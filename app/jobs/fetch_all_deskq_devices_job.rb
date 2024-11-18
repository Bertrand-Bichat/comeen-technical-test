# frozen_string_literal: true

class FetchAllDeskqDevicesJob < ApplicationJob
  queue_as :default

  def perform
    devices = Deskq::Devices::DevicesService.new.list
    devices.each do |device|
      desk = Desk.find_by(sync_id: device["desk_sync_id"])
      next if desk.blank?

      device = Deskq::Device.find_or_initialize_by(
        api_id: device["id"],
        desk_id: desk.id,
        desk_sync_id: device["desk_sync_id"],
      )

      device.assign_attributes({
        color: device["color"],
        last_synced_at: Time.current,
      })

      device.save!
    end
  end
end
