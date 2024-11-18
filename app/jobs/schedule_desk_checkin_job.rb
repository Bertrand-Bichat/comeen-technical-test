# frozen_string_literal: true

class ScheduleDeskCheckinJob < ApplicationJob
  queue_as :default

  def perform(desk_booking_id)
    desk_booking = DeskBooking.find(desk_booking_id)
    desk_booking.check_in!
  end
end
