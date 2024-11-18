# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string           default(""), not null
#  encrypted_password :string           default(""), not null
#  time_zone          :string           default("UTC"), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class UserSerializer
  include JSONAPI::Serializer

  set_type :user
  attributes :email, :time_zone

  has_many :desk_bookings
end
