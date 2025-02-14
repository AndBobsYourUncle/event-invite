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

ActiveRecord::Schema[8.0].define(version: 2024_12_08_021603) do
  create_table "event_contacts", force: :cascade do |t|
    t.integer "event_id", null: false
    t.string "name"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_contacts_on_event_id"
  end

  create_table "event_registries", force: :cascade do |t|
    t.integer "event_id", null: false
    t.string "name"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_registries_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "event_time"
    t.string "location"
    t.string "address_1"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.datetime "rsvp_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "invite_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "email_address"
    t.integer "rsvp_adult_count"
    t.integer "rsvp_answer", default: 0
    t.integer "rsvp_count"
    t.index ["invite_code"], name: "index_invitations_on_invite_code", unique: true
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.string "full_name"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "event_contacts", "events"
  add_foreign_key "event_registries", "events"
  add_foreign_key "invitations", "users"
  add_foreign_key "sessions", "users"
end
