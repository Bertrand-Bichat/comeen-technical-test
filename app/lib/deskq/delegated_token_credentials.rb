# frozen_string_literal: true

module Deskq
  # This class is incomplete and is only meant to be used as a reference
  class DelegatedTokenCredentials < Signet::OAuth2::Client
    attr_reader :grant, :owner, :domain

    def initialize(integration_grant)
      @grant = integration_grant
      @owner = integration_grant.user
      @domain = integration_grant.domain

      super(
        client_id: Rails.configuration.deskq_devices[:client_id],
        client_secret: Rails.configuration.deskq_devices[:client_secret],
        authorization_uri: "https://accounts.google.com/o/oauth2/v2/auth",
        token_credential_uri: "https://oauth2.googleapis.com/token",
        include_granted_scopes: false,
        redirect_uri: "https://localhost:3000/callback",
        scope: Rails.configuration.integrations.dig(:deskq, :scopes),
        )
    end

    def destroy
      OauthToken.where(integration_grant: grant).destroy_all
    end
  end
end
