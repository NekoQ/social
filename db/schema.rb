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

ActiveRecord::Schema.define(version: 2021_02_16_171409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lists", force: :cascade do |t|
    t.string "name"
    t.string "people", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_lists_on_name", unique: true
  end

  create_table "networks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_networks_on_name", unique: true
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "lists", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "posts", force: :cascade do |t|
    t.date "date"
    t.string "network"
    t.string "link"
    t.string "author_name"
    t.bigint "person_id", null: false
    t.text "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_posts_on_person_id"
  end

  add_foreign_key "posts", "people"

  create_view "post_searches", materialized: true, sql_definition: <<-SQL
      SELECT posts.id AS post_id,
      to_tsvector('english'::regconfig, COALESCE(posts.text, ''::text)) AS tsv_document
     FROM posts;
  SQL
  add_index "post_searches", ["post_id"], name: "index_post_searches_on_post_id", unique: true
  add_index "post_searches", ["tsv_document"], name: "index_post_searches_on_tsv_document", using: :gin

end
