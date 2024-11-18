# frozen_string_literal: true

class ScheduleDeskCheckoutJob < ApplicationJob
  queue_as :default

  def perform(desk_booking_id)
    desk_booking = DeskBooking.find(desk_booking_id)
    desk_booking.check_out!
  end
end
