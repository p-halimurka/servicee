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

ActiveRecord::Schema[7.0].define(version: 2023_06_15_150636) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.string "bookable_type", null: false
    t.bigint "bookable_id", null: false
    t.bigint "service_provider_id"
    t.bigint "employee_id"
    t.bigint "service_consumer_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bookable_type", "bookable_id"], name: "index_bookings_on_bookable"
    t.index ["employee_id"], name: "index_bookings_on_employee_id"
    t.index ["service_consumer_id"], name: "index_bookings_on_service_consumer_id"
    t.index ["service_provider_id"], name: "index_bookings_on_service_provider_id"
  end

  create_table "employees", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "employer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_employees_on_employer_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "room_id"
    t.bigint "user_id"
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "read", default: false
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "off_days", force: :cascade do |t|
    t.bigint "service_provider_id"
    t.bigint "employee_id"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_off_days_on_employee_id"
    t.index ["service_provider_id"], name: "index_off_days_on_service_provider_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "reviewable_type", null: false
    t.bigint "reviewable_id", null: false
    t.string "comment"
    t.integer "rating"
    t.bigint "service_consumer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reviewable_type", "reviewable_id"], name: "index_reviews_on_reviewable"
    t.index ["service_consumer_id"], name: "index_reviews_on_service_consumer_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.bigint "first_subscriber_id"
    t.bigint "second_subscriber_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_subscriber_id"], name: "index_rooms_on_first_subscriber_id"
    t.index ["second_subscriber_id"], name: "index_rooms_on_second_subscriber_id"
  end

  create_table "service_categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_categories_services", id: false, force: :cascade do |t|
    t.bigint "service_category_id", null: false
    t.bigint "service_id", null: false
  end

  create_table "service_consumers", force: :cascade do |t|
    t.bigint "user_id"
    t.string "phone_number"
    t.jsonb "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_service_consumers_on_user_id"
  end

  create_table "service_provider_categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_provider_categories_providers", id: false, force: :cascade do |t|
    t.bigint "service_provider_id", null: false
    t.bigint "service_provider_category_id", null: false
  end

  create_table "service_providers", force: :cascade do |t|
    t.bigint "user_id"
    t.string "bio"
    t.string "phone_number"
    t.jsonb "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "person_type", default: 0, null: false
    t.time "opening_hour"
    t.time "closing_hour"
    t.index ["user_id"], name: "index_service_providers_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.decimal "price", precision: 8, scale: 2, default: "0.0"
    t.integer "duration_in_minutes"
    t.boolean "whole_day"
    t.boolean "active"
    t.bigint "service_provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "requires_confirmation", default: false
    t.integer "pricing_type", default: 0
    t.index ["service_provider_id"], name: "index_services_on_service_provider_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_name", default: "", null: false
    t.string "first_name", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "employees", "service_providers", column: "employer_id"
  add_foreign_key "rooms", "users", column: "first_subscriber_id"
  add_foreign_key "rooms", "users", column: "second_subscriber_id"
end
