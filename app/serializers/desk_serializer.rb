# frozen_string_literal: true

# == Schema Information
#
# Table name: desks
#
#  id                   :integer          not null, primary key
#  name                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  google_desk_sheet_id :integer
#  sync_id              :string
#
# Indexes
#
#  index_desks_on_google_desk_sheet_id  (google_desk_sheet_id)
#  index_desks_on_sync_id               (sync_id) UNIQUE
#
# Foreign Keys
#
#  google_desk_sheet_id  (google_desk_sheet_id => google_desk_sheets.id)
#
class DeskSerializer
  include JSONAPI::Serializer

  set_type :desk
  attributes :name

  has_many :desk_bookings
end
