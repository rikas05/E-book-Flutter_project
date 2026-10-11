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

ActiveRecord::Schema[8.1].define(version: 2026_08_29_000001) do
  create_table "ebooks", force: :cascade do |t|
    t.string "author", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "file_path", null: false
    t.bigint "file_size", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.datetime "uploaded_at", default: -> { "CURRENT_TIMESTAMP" }
    t.index ["author"], name: "index_ebooks_on_author"
    t.index ["title"], name: "index_ebooks_on_title"
    t.index ["uploaded_at"], name: "index_ebooks_on_uploaded_at"
  end
end
