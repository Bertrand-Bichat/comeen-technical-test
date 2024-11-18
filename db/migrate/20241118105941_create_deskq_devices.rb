# frozen_string_literal: true

class CreateDeskqDevices < ActiveRecord::Migration[7.2]
  def change
    create_table(:deskq_devices) do |t|
      t.string(:color)
      t.string(:desk_sync_id)
      t.datetime(:last_synced_at)
      t.timestamps
    end
  end
end
