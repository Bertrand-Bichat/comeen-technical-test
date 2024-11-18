# frozen_string_literal: true

# == Schema Information
#
# Table name: desk_bookings
#
#  id             :integer          not null, primary key
#  end_datetime   :datetime
#  start_datetime :datetime
#  state          :string           default("booked"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  desk_id        :integer          not null
#  user_id        :integer          not null
#
# Indexes
#
#  index_desk_bookings_on_desk_id  (desk_id)
#  index_desk_bookings_on_user_id  (user_id)
#
# Foreign Keys
#
#  desk_id  (desk_id => desks.id)
#  user_id  (user_id => users.id)
#
class DeskBooking < ApplicationRecord
  include AASM

  belongs_to :desk
  belongs_to :user

  validates :start_datetime, :end_datetime, presence: true

  scope :overlapping, ->(start_datetime, end_datetime) do
    where(
      "`start_datetime` BETWEEN :starting AND :ending OR " \
        "`end_datetime` BETWEEN :starting AND :ending OR " \
        "(`start_datetime` < :starting AND `end_datetime` > :ending)",
      starting: start_datetime,
      ending: end_datetime,
    )
  end

  after_create_commit :manage_desk_availability

  aasm column: :state do
    state :booked, initial: true
    state :canceled
    state :checked_in
    state :checked_out

    event :check_in do
      transitions from: :booked, to: :checked_in, guard: :can_checkin?
      after do
        set_device_as_occupied!
      end
    end

    event :check_out do
      transitions from: :checked_in, to: :checked_out, guard: :can_checkout?
      after do
        set_device_as_available!
      end
    end

    event :cancel do
      transitions from: [:booked, :checked_in], to: :canceled
      after do
        set_device_as_available!
      end
    end
  end

  def can_checkin?
    available = desk.deskq_device.present? ? desk.deskq_device.available? : true
    available && (start_datetime <= user.current_local_time)
  end

  def can_checkout?
    occupied = desk.deskq_device.present? ? desk.deskq_device.occupied? : true
    occupied && (end_datetime <= user.current_local_time)
  end

  def set_device_as_available!
    return if desk.deskq_device.blank?

    desk.deskq_device.mark_as_available!
  end

  def set_device_as_occupied!
    return if desk.deskq_device.blank?

    desk.deskq_device.mark_as_occupied!
  end

  private

  def manage_desk_availability
    ScheduleDeskCheckinJob.set(wait_until: start_datetime.in_time_zone(user.time_zone)).perform_later(id)
    ScheduleDeskCheckoutJob.set(wait_until: end_datetime.in_time_zone(user.time_zone)).perform_later(id)
  end
end
