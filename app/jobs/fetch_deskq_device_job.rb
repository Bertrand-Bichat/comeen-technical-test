# frozen_string_literal: true

class FetchDeskqDeviceJob < ApplicationJob
  queue_as :default

  def perform(desk_id)
    desk = Desk.find(desk_id)
    return if desk.sync_id.blank? || desk.deskq_device.present?

    devices = Deskq::Devices::DevicesService.new.list
    devices.each do |device|
      next unless device["desk_sync_id"] == desk.sync_id

      Deskq::Device.create!(
        color: device["color"],
        api_id: device["id"],
        desk_id: desk.id,
        desk_sync_id: device["desk_sync_id"],
        last_synced_at: Time.current,
      )
      break
    end
  end
end
