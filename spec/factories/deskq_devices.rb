# frozen_string_literal: true

FactoryBot.define do
  factory :deskq_device, class: "Deskq::Device" do
    desk

    transient do
      id { Faker::Number.number(digits: 2) }
      sync_id { Faker::Alphanumeric.alpha(number: 6) }
    end

    color { ["GREEN", "RED"].sample }
    api_id { id.to_s }
    desk_sync_id { sync_id }
  end
end
