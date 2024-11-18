# frozen_string_literal: true

# == Schema Information
#
# Table name: integration_grants
#
#  id         :integer          not null, primary key
#  domain     :string           not null
#  provider   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_integration_grants_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class IntegrationGrant < ApplicationRecord
  belongs_to :user

  validates :provider, presence: true, inclusion: {
    in: Rails.application.config.integrations.keys,
  }
  validates :domain, presence: true, inclusion: {
    in: Rails.application.config.integrations.values.flat_map(&:keys),
  }

  normalizes :provider, with: ->(provider) { provider.to_sym }
  normalizes :domain, with: ->(domain) { domain.to_sym }

  scope :for, ->(provider, domain) { where(provider:, domain:) }

  before_destroy do
    credentials.destroy
  end

  def credentials
    Integrations::Credentials.resolve(provider, domain).new(self)
  end
end
