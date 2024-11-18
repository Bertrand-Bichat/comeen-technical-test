# frozen_string_literal: true

require_dependency "deskq"

module Deskq
  class Device < ApplicationRecord
    validates :deskQ_device_id, presence: true, uniqueness: true

    belongs_to :desk, optional: true
  end
end
