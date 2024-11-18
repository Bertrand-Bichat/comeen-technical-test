# frozen_string_literal: true

require "rails_helper"

RSpec.describe(ScheduleDeskCheckinJob, type: :job) do
  describe "#perform" do
    let(:desk_booking) { create(:desk_booking, start_datetime: 2.days.ago, end_datetime: 2.days.from_now, state: :booked) }

    it "calls check_in! on the desk_booking" do
      allow(desk_booking).to(receive(:check_in!))
      described_class.perform_now(desk_booking.id)
      expect(desk_booking.reload.state).to(eq("checked_in"))
    end
  end
end
