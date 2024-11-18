# frozen_string_literal: true

module Deskq
  class DevicesController < ApplicationController
    before_action :load_device, except: [:index]

    def index
      @devices = Device.all

      render(jsonapi: @devices)
    end

    def list_sync_changes
      @desks_from_api = Deskq::Devices::Synchronizer.new(
        Integrations.for(current_user, :deskq, :devices).credentials,
        @device,
      ).fetch_sync_changes

      render(jsonapi: @desks_from_api)
    end

    def change_led_color
      @desks_from_api = Deskq::Devices::Synchronizer.new(
        Integrations.for(current_user, :deskq, :devices).credentials,
        @device,
      ).change_led_color!

      render(jsonapi: @desks_from_api)
    end

    private

    def load_device
      @device = Device.find(params[:id])
    end
  end
end
