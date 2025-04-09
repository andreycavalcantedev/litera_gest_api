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

ActiveRecord::Schema[7.1].define(version: 2025_04_07_182353) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.integer "phone"
    t.integer "whatsapp"
    t.string "email"
    t.time "opening_time"
    t.time "closing_time"
    t.integer "cnpj"
    t.string "instagram"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "type_users", force: :cascade do |t|
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "cpf"
    t.integer "card_identity"
    t.bigint "type_user_id", null: false
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "library_id"
    t.string "password_digest"
    t.index ["library_id"], name: "index_users_on_library_id"
    t.index ["type_user_id"], name: "index_users_on_type_user_id"
  end

  add_foreign_key "users", "libraries"
  add_foreign_key "users", "type_users"
end
