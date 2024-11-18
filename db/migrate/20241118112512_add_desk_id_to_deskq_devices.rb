# frozen_string_literal: true

class AddDeskIdToDeskqDevices < ActiveRecord::Migration[7.2]
  def change
    add_reference(:deskq_devices, :desk, null: true, foreign_key: true)
  end
end
