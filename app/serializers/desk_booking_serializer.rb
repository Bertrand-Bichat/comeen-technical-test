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
class DeskBookingSerializer
  include JSONAPI::Serializer

  set_type :desk_booking
  attributes :start_datetime, :end_datetime, :state

  belongs_to :user
  belongs_to :desk
end
