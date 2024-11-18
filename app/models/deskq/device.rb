# frozen_string_literal: true

require_dependency "deskq"

module Deskq
  class Device < ApplicationRecord
    COLORS = ["RED", "GREEN"].freeze

    validates :api_id, presence: true, uniqueness: true
    validates :color, presence: true, inclusion: { in: COLORS }
    validates :desk_sync_id, presence: true

    belongs_to :desk, optional: true

    def new_color
      color == "RED" ? "GREEN" : "RED"
    end
  end
end
