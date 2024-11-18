# frozen_string_literal: true

class FetchAllDeskqDevicesJob < ApplicationJob
  queue_as :default

  def perform
    sync_deskq_devices
    sync_color_from_desk_bookings
  end

  private

  def sync_deskq_devices
    devices = Deskq::Devices::DevicesService.new.list
    devices.each do |device|
      desk = Desk.find_by(sync_id: device["desk_sync_id"])
      next if desk.blank?

      new_device = Deskq::Device.find_or_initialize_by(
        api_id: device["id"],
        desk_id: desk.id,
        desk_sync_id: device["desk_sync_id"],
      )

      new_device.assign_attributes(
        color: device["color"],
        last_synced_at: Time.current,
      )

      new_device.save!
    end
  end

  def sync_color_from_desk_bookings
    DeskBooking.where(state: "checked_in").find_each(&:set_device_as_occupied!)
    DeskBooking.where.not(state: "checked_in").find_each(&:set_device_as_available!)
  end
end
