# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_11_18_113351) do
  create_table "desk_bookings", force: :cascade do |t|
    t.integer "desk_id", null: false
    t.integer "user_id", null: false
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state", default: "booked", null: false
    t.index ["desk_id"], name: "index_desk_bookings_on_desk_id"
    t.index ["user_id"], name: "index_desk_bookings_on_user_id"
  end

  create_table "deskq_devices", force: :cascade do |t|
    t.string "color"
    t.string "desk_sync_id"
    t.datetime "last_synced_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "desk_id"
    t.index ["desk_id"], name: "index_deskq_devices_on_desk_id"
  end

  create_table "deskq_oauth_tokens", force: :cascade do |t|
    t.string "access_token"
    t.string "refresh_token"
    t.string "scope"
    t.string "expires_at"
    t.integer "integration_grant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["integration_grant_id"], name: "index_deskq_oauth_tokens_on_integration_grant_id"
  end

  create_table "desks", force: :cascade do |t|
    t.string "name"
    t.string "sync_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "google_desk_sheet_id"
    t.index ["google_desk_sheet_id"], name: "index_desks_on_google_desk_sheet_id"
    t.index ["sync_id"], name: "index_desks_on_sync_id", unique: true
  end

  create_table "google_desk_sheets", force: :cascade do |t|
    t.string "google_sheet_id"
    t.datetime "last_synced_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["google_sheet_id"], name: "index_google_desk_sheets_on_google_sheet_id", unique: true
  end

  create_table "google_oauth_tokens", force: :cascade do |t|
    t.string "access_token"
    t.string "refresh_token"
    t.string "scope"
    t.string "expires_at"
    t.integer "integration_grant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["integration_grant_id"], name: "index_google_oauth_tokens_on_integration_grant_id"
  end

  create_table "integration_grants", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "domain", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_integration_grants_on_user_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.integer "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer "resource_owner_id"
    t.integer "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.string "scopes"
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "time_zone", default: "UTC", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "desk_bookings", "desks"
  add_foreign_key "desk_bookings", "users"
  add_foreign_key "deskq_devices", "desks"
  add_foreign_key "deskq_oauth_tokens", "integration_grants"
  add_foreign_key "desks", "google_desk_sheets"
  add_foreign_key "google_oauth_tokens", "integration_grants"
  add_foreign_key "integration_grants", "users"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
end
