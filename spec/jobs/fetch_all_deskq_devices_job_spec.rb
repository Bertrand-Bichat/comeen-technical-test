# frozen_string_literal: true

require "rails_helper"

RSpec.describe(FetchAllDeskqDevicesJob, type: :job) do
  let(:devices_service) { instance_double(Deskq::Devices::DevicesService) }
  let(:device_data) do
    [
      { "id" => "1", "color" => "RED", "desk_sync_id" => "sync1" },
      { "id" => "2", "color" => "GREEN", "desk_sync_id" => "sync2" },
      { "id" => "3", "color" => "RED", "desk_sync_id" => "unknown_sync" },
    ]
  end
  let!(:desk1) { create(:desk, sync_id: "sync1") }
  let!(:desk2) { create(:desk, sync_id: "sync2") }

  before do
    allow(Deskq::Devices::DevicesService).to(receive(:new).and_return(devices_service))
    allow(devices_service).to(receive(:list).and_return(device_data))
  end

  it "fetches devices from the service" do
    described_class.perform_now

    expect(devices_service).to(have_received(:list))
  end

  it "creates or updates devices with valid desks" do
    described_class.perform_now

    device1 = Deskq::Device.find_by(api_id: "1")
    device2 = Deskq::Device.find_by(api_id: "2")

    expect(device1).to(have_attributes(
      color: "RED",
      desk_id: desk1.id,
      desk_sync_id: "sync1",
    ))
    expect(device2).to(have_attributes(
      color: "GREEN",
      desk_id: desk2.id,
      desk_sync_id: "sync2",
    ))
  end

  it "ignores devices without a matching desk" do
    described_class.perform_now

    expect(Deskq::Device.find_by(api_id: "3")).to(be_nil)
  end
end
