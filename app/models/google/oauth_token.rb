# frozen_string_literal: true

# == Schema Information
#
# Table name: google_oauth_tokens
#
#  id                   :integer          not null, primary key
#  access_token         :string
#  expires_at           :string
#  refresh_token        :string
#  scope                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  integration_grant_id :integer          not null
#
# Indexes
#
#  index_google_oauth_tokens_on_integration_grant_id  (integration_grant_id)
#
# Foreign Keys
#
#  integration_grant_id  (integration_grant_id => integration_grants.id)
#
require_dependency "google"

module Google
  class OauthToken < ApplicationRecord
    belongs_to :integration_grant

    validates :access_token, presence: true
    validates :refresh_token, presence: true
    validates :expires_at, presence: true
  end
end
