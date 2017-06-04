# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170604190340) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "properties", force: :cascade do |t|
    t.string "title"
    t.integer "price"
    t.string "description"
    t.integer "beds"
    t.integer "baths"
    t.integer "square_meters"
    t.geometry "lonlat", limit: {:srid=>0, :type=>"st_point"}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "properties_provinces", id: false, force: :cascade do |t|
    t.bigint "property_id", null: false
    t.bigint "province_id", null: false
    t.index ["property_id", "province_id"], name: "index_properties_provinces_on_property_id_and_province_id"
    t.index ["province_id", "property_id"], name: "index_properties_provinces_on_province_id_and_property_id"
  end

  create_table "provinces", force: :cascade do |t|
    t.string "name"
    t.geometry "area", limit: {:srid=>0, :type=>"st_polygon"}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
