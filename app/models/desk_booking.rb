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

  aasm column: :state do
    state :booked, initial: true
    state :canceled
    state :checked_in
    state :checked_out

    event :check_in do
      transitions from: :booked, to: :checked_in, guard: :can_checkin?
    end

    event :check_out do
      transitions from: :checked_in, to: :checked_out
    end

    event :cancel do
      transitions from: [:booked, :checked_in], to: :canceled
    end
  end

  def can_checkin?
    start_datetime < Time.current
  end
end
