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

ActiveRecord::Schema[7.0].define(version: 2023_03_03_134534) do
  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "kind", default: "TEST"
    t.string "zip", default: "64000"
    t.string "country", default: "MX"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "client_id", null: false
    t.string "name"
    t.string "kind", default: "TEST"
    t.decimal "length", precision: 5, scale: 2
    t.decimal "width", precision: 5, scale: 2
    t.decimal "height", precision: 5, scale: 2
    t.string "distance_unit", default: "cm"
    t.decimal "weight", precision: 5, scale: 2
    t.string "mass_unit", default: "kg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_items_on_client_id"
  end

  add_foreign_key "items", "clients"
end
