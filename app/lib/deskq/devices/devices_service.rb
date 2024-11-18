# frozen_string_literal: true

module Deskq
  module Devices
    class DevicesService
      def initialize
        @service = Faraday.new
        @api_key = Rails.configuration.deskq_devices[:api_key]
        @base_url = Rails.configuration.integrations.dig(:deskq, :base_url)
      end

      def list
        response = @service.get(@base_url) do |req|
          req.headers["Content-Type"] = "application/json"
          req.headers["Authorization"] = "Bearer #{@api_key}"
        end

        JSON.parse(response.body)
      end

      def change_color(device_id)
        device = Device.find(device_id)

        response = @service.put("#{@base_url}/#{device.api_id}") do |req|
          req.headers["Content-Type"] = "application/json"
          req.headers["Authorization"] = "Bearer #{@api_key}"
          req.params["color"] = device.change_color
        end

        JSON.parse(response.body)
      end
    end
  end
end
