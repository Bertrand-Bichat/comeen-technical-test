# frozen_string_literal: true

require_dependency "deskq"

module Deskq
  class Device < ApplicationRecord
    validates :api_id, presence: true, uniqueness: true

    belongs_to :desk, optional: true

    def change_color
      color == "RED" ? "GREEN" : "RED"
    end
  end
end
