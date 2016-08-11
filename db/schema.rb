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

ActiveRecord::Schema.define(version: 20160809204841) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["resource_id"], name: "index_activities_on_resource_id", using: :btree
  end

  create_table "crops", force: :cascade do |t|
    t.string   "name"
    t.integer  "duration"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.decimal  "seed_weight"
    t.decimal  "product_plant"
  end

  create_table "farms", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "farm_code"
    t.decimal  "lat"
    t.decimal  "lng"
    t.string   "layout"
    t.decimal  "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_farms_on_user_id", using: :btree
  end

  create_table "resources", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stages", force: :cascade do |t|
    t.string   "name"
    t.integer  "start_date"
    t.integer  "crop_id"
    t.decimal  "tmax"
    t.decimal  "tmin"
    t.float    "precip"
    t.integer  "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crop_id"], name: "index_stages_on_crop_id", using: :btree
  end

  create_table "stocks", force: :cascade do |t|
    t.integer  "farm_id"
    t.integer  "resource_id"
    t.float    "amount"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["farm_id"], name: "index_stocks_on_farm_id", using: :btree
    t.index ["resource_id"], name: "index_stocks_on_resource_id", using: :btree
  end

  create_table "sub_farm_activities", force: :cascade do |t|
    t.integer  "sub_farm_id"
    t.integer  "activity_id"
    t.float    "amount"
    t.datetime "date"
    t.string   "title"
    t.text     "note"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["activity_id"], name: "index_sub_farm_activities_on_activity_id", using: :btree
    t.index ["sub_farm_id"], name: "index_sub_farm_activities_on_sub_farm_id", using: :btree
  end

  create_table "sub_farms", force: :cascade do |t|
    t.integer  "farm_id"
    t.integer  "crop_id"
    t.float    "size"
    t.float    "crop_weight"
    t.datetime "start_date"
    t.datetime "harvest_date"
    t.string   "layout"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "active",       default: true
    t.float    "yield"
    t.float    "x"
    t.float    "y"
    t.float    "width"
    t.float    "height"
    t.index ["crop_id"], name: "index_sub_farms_on_crop_id", using: :btree
    t.index ["farm_id"], name: "index_sub_farms_on_farm_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "country"
    t.string   "city"
    t.string   "phone"
    t.string   "address"
    t.datetime "joined"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "weather_logs", force: :cascade do |t|
    t.decimal  "lat"
    t.decimal  "lng"
    t.decimal  "tmax"
    t.decimal  "tmin"
    t.float    "precip"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_weather_logs_on_date", using: :btree
  end

  add_foreign_key "activities", "resources"
  add_foreign_key "stages", "crops"
  add_foreign_key "stocks", "farms"
  add_foreign_key "stocks", "resources"
  add_foreign_key "sub_farm_activities", "activities"
  add_foreign_key "sub_farm_activities", "sub_farms"
  add_foreign_key "sub_farms", "crops"
  add_foreign_key "sub_farms", "farms"
end
