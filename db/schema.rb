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

ActiveRecord::Schema[7.0].define(version: 2023_09_04_122008) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "device_sellers", force: :cascade do |t|
    t.bigint "device_id"
    t.bigint "seller_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_device_sellers_on_device_id"
    t.index ["seller_id"], name: "index_device_sellers_on_seller_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "device"
    t.string "status"
    t.string "ipadrrs"
    t.integer "cont"
    t.datetime "last_seen"
    t.string "padlock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.bigint "seller_id"
    t.index ["seller_id"], name: "index_devices_on_seller_id"
  end

  create_table "dose_prices", force: :cascade do |t|
    t.decimal "price", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sellers", force: :cascade do |t|
    t.string "status"
    t.string "nome"
    t.string "cardRFID"
    t.string "cargo"
    t.string "email"
    t.integer "contador"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "creator_id"
    t.index ["user_id"], name: "index_sellers_on_user_id"
  end

  create_table "sms_logs", force: :cascade do |t|
    t.string "from_number"
    t.string "to_number"
    t.text "body"
    t.datetime "sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sms_messages", force: :cascade do |t|
    t.string "smsbody"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.string "name"
    t.string "phone"
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "device_sellers", "devices"
  add_foreign_key "device_sellers", "sellers"
  add_foreign_key "devices", "sellers"
  add_foreign_key "sellers", "users"
  add_foreign_key "sellers", "users", column: "creator_id"
end
