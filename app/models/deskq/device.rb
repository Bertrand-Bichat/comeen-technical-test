# frozen_string_literal: true

require_dependency "deskq"

module Deskq
  class Device < ApplicationRecord
    COLORS = ["RED", "GREEN"].freeze

    belongs_to :desk

    validates :api_id, presence: true, uniqueness: true
    validates :color, presence: true, inclusion: { in: COLORS }
    validates :desk_sync_id, presence: true

    before_validation :link_desk, on: :create

    def new_color
      color == "RED" ? "GREEN" : "RED"
    end

    def available?
      color == "GREEN"
    end

    def occupied?
      color == "RED"
    end

    def mark_as_available!
      return if color == "GREEN"

      Deskq::Devices::DevicesService.change_color(id, "GREEN")
    end

    def mark_as_occupied!
      return if color == "RED"

      Deskq::Devices::DevicesService.change_color(id, "RED")
    end

    private

    def link_desk
      self.desk = Desk.find_by(sync_id: desk_sync_id)
    end
  end
end
