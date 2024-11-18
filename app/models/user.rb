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
class User < ApplicationRecord
  devise :database_authenticatable, :registerable

  # rubocop:disable Rails/InverseOf (the Doorkeeper's models do not have the corresponding associations)
  has_many :access_grants,
    class_name: "Doorkeeper::AccessGrant",
    foreign_key: :resource_owner_id,
    dependent: :delete_all # faster than :destroy since we're not running callbacks

  has_many :access_tokens,
    class_name: "Doorkeeper::AccessToken",
    foreign_key: :resource_owner_id,
    dependent: :delete_all # faster than :destroy since we're not running callbacks
  # rubocop:enable Rails/InverseOf

  has_many :desk_bookings, dependent: :destroy
  has_many :integration_grants, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :time_zone, presence: true, inclusion: { in: TZInfo::Timezone.all_identifiers }

  def current_local_time
    Time.now.in_time_zone(time_zone)
  end
end
