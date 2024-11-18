# frozen_string_literal: true

require "rails_helper"

RSpec.describe(ScheduleDeskCheckoutJob, type: :job) do
  describe "#perform" do
    let(:desk_booking) { create(:desk_booking, start_datetime: 2.days.ago, end_datetime: 1.day.ago, state: :checked_in) }

    it "calls check_in! on the desk_booking" do
      allow(desk_booking).to(receive(:check_out!))
      described_class.perform_now(desk_booking.id)
      expect(desk_booking.reload.state).to(eq("checked_out"))
    end
  end
end
