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

ActiveRecord::Schema[7.1].define(version: 2025_05_23_192242) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "country", null: false
    t.string "state", null: false
    t.string "city", null: false
    t.string "zipcode", null: false
    t.string "district", null: false
    t.string "street", null: false
    t.string "number", null: false
    t.string "complement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.date "birthdate"
    t.date "death_date"
    t.string "url_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "black_listed_tokens", force: :cascade do |t|
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_users", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "user_id", null: false
    t.datetime "date_reservation"
    t.datetime "date_devolution"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_book_users_on_book_id"
    t.index ["user_id"], name: "index_book_users_on_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "year_published"
    t.string "gender"
    t.string "isbn"
    t.integer "total_quantity"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id"
    t.bigint "publisher_id"
    t.index ["author_id"], name: "index_books_on_author_id"
    t.index ["publisher_id"], name: "index_books_on_publisher_id"
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "whatsapp"
    t.string "email"
    t.time "opening_time"
    t.time "closing_time"
    t.string "cnpj"
    t.string "instagram"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "address_id"
    t.index ["address_id"], name: "index_libraries_on_address_id"
  end

  create_table "publishers", force: :cascade do |t|
    t.string "name"
    t.string "cnpj"
    t.string "phone"
    t.string "email"
    t.string "url"
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
    t.string "cpf"
    t.string "card_identity"
    t.bigint "type_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "library_id"
    t.string "password_digest"
    t.bigint "address_id"
    t.index ["address_id"], name: "index_users_on_address_id"
    t.index ["library_id"], name: "index_users_on_library_id"
    t.index ["type_user_id"], name: "index_users_on_type_user_id"
  end

  add_foreign_key "book_users", "books"
  add_foreign_key "book_users", "users"
  add_foreign_key "books", "authors"
  add_foreign_key "books", "publishers"
  add_foreign_key "libraries", "addresses"
  add_foreign_key "users", "addresses"
  add_foreign_key "users", "libraries"
  add_foreign_key "users", "type_users"
end
