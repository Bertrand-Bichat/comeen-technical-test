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
module Google
  class DeskSheetSerializer
    include JSONAPI::Serializer

    set_type :google_desk_sheet
    attributes :google_sheet_id
  end
end
