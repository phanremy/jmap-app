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

ActiveRecord::Schema[7.1].define(version: 2024_05_07_073542) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "links", force: :cascade do |t|
    t.string "sku", null: false
    t.bigint "space_id", null: false
    t.bigint "owner_id", null: false
    t.datetime "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_links_on_owner_id"
    t.index ["sku"], name: "index_links_on_sku", unique: true
    t.index ["space_id", "owner_id"], name: "index_links_on_space_id_and_owner_id", unique: true
    t.index ["space_id"], name: "index_links_on_space_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "type", null: false
    t.string "country", null: false
    t.string "county"
    t.string "city"
    t.string "original_name"
    t.index ["country", "county", "city"], name: "index_locations_on_country_and_county_and_city", unique: true
    t.index ["country", "county"], name: "index_locations_on_country_and_county", unique: true, where: "(city IS NULL)"
    t.index ["country"], name: "index_locations_on_country", unique: true, where: "((county IS NULL) AND (city IS NULL))"
  end

  create_table "posts", force: :cascade do |t|
    t.string "url"
    t.string "title"
    t.text "content"
    t.bigint "location_id"
    t.bigint "creator_id", null: false
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string "frequency"
    t.bigint "main_id"
    t.string "raw_address"
    t.decimal "longitude"
    t.decimal "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_posts_on_creator_id"
    t.index ["location_id"], name: "index_posts_on_location_id"
    t.index ["main_id"], name: "index_posts_on_main_id"
  end

  create_table "space_posts", force: :cascade do |t|
    t.bigint "space_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_space_posts_on_post_id"
    t.index ["space_id"], name: "index_space_posts_on_space_id"
  end

  create_table "space_users", force: :cascade do |t|
    t.bigint "space_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_id", "user_id"], name: "index_space_users_on_space_id_and_user_id", unique: true
    t.index ["space_id"], name: "index_space_users_on_space_id"
    t.index ["user_id"], name: "index_space_users_on_user_id"
  end

  create_table "spaces", force: :cascade do |t|
    t.string "description", null: false
    t.bigint "owner_id", null: false
    t.boolean "public", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_spaces_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.boolean "confirmed", default: true, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "links", "spaces"
  add_foreign_key "links", "users", column: "owner_id"
  add_foreign_key "posts", "posts", column: "main_id"
  add_foreign_key "posts", "users", column: "creator_id"
  add_foreign_key "space_posts", "posts"
  add_foreign_key "space_posts", "spaces"
  add_foreign_key "space_users", "spaces"
  add_foreign_key "space_users", "users"
  add_foreign_key "spaces", "users", column: "owner_id"
end
