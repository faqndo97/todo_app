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

ActiveRecord::Schema[8.0].define(version: 2025_03_17_093058) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "item_status", ["pending", "complete"]
  create_enum "locale", ["en", "es"]

  create_table "items", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.enum "status", default: "pending", null: false, enum_type: "item_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "list_id", null: false
    t.integer "position", null: false
    t.index ["list_id"], name: "index_items_on_list_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "locale", default: "en", null: false, enum_type: "locale"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "items", "lists"
  add_foreign_key "items", "users"
  add_foreign_key "lists", "users"
  add_foreign_key "sessions", "users"
end
