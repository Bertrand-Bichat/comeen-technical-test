# frozen_string_literal: true

require "rails_helper"

RSpec.describe(FetchDeskqDeviceJob, type: :job) do
  let(:devices_service) { instance_double(Deskq::Devices::DevicesService) }
  let(:device_data) do
    [
      { "id" => "1", "color" => "RED", "desk_sync_id" => "sync1" },
      { "id" => "2", "color" => "GREEN", "desk_sync_id" => "sync2" },
    ]
  end

  let!(:desk) { create(:desk, sync_id: "sync1") }

  before do
    allow(Deskq::Devices::DevicesService).to(receive(:new).and_return(devices_service))
    allow(devices_service).to(receive(:list).and_return(device_data))
  end

  it "calls the DevicesService to fetch devices" do
    described_class.perform_now(desk.id)

    expect(devices_service).to(have_received(:list))
  end

  it "creates a Deskq::Device for a matching desk" do
    described_class.perform_now(desk.id)

    device = Deskq::Device.find_by(api_id: "1")
    expect(device).to(be_present)
    expect(device.desk_id).to(eq(desk.id))
    expect(device.color).to(eq("RED"))
  end

  it "does not create a device if the desk has a device already" do
    create(:deskq_device, desk: desk)

    described_class.perform_now(desk.id)

    expect(Deskq::Device.count).to(eq(1))
  end

  it "does not create a device if the desk_sync_id is blank" do
    desk.update(sync_id: nil)

    described_class.perform_now(desk.id)

    expect(Deskq::Device.count).to(eq(0))
  end

  it "breaks after creating the first matching device" do
    described_class.perform_now(desk.id)

    device = Deskq::Device.find_by(api_id: "1")
    expect(device).to(be_present)
    expect(Deskq::Device.count).to(eq(1))
  end
end
