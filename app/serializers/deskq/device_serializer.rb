# frozen_string_literal: true

module Deskq
  class DeviceSerializer
    include JSONAPI::Serializer

    set_type :deskq_device
    attributes :desk_sync_id
  end
end
