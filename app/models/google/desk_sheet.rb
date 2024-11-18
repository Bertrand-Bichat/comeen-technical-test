# frozen_string_literal: true

# == Schema Information
#
# Table name: google_desk_sheets
#
#  id              :integer          not null, primary key
#  last_synced_at  :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  google_sheet_id :string
#
# Indexes
#
#  index_google_desk_sheets_on_google_sheet_id  (google_sheet_id) UNIQUE
#
require_dependency "google"

module Google
  class DeskSheet < ApplicationRecord
    validates :google_sheet_id, presence: true, uniqueness: true

    has_many :desks,
      foreign_key: :google_desk_sheet_id,
      dependent: :nullify,
      inverse_of: :google_desk_sheet
  end
end
