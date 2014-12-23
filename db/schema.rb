# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141218174041) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animals", force: true do |t|
    t.string   "species_name"
    t.string   "common_name"
    t.string   "species_cd"
    t.integer  "species_nr"
    t.integer  "gen_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "animals", ["gen_id"], name: "index_animals_on_gen_id", using: :btree

  create_table "families", force: true do |t|
    t.string   "family_name"
    t.string   "common_name"
    t.integer  "family_nr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gens", force: true do |t|
    t.string   "genus_name"
    t.string   "common_name"
    t.integer  "family_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gens", ["family_id"], name: "index_gens_on_family_id", using: :btree

  create_table "psus", force: true do |t|
    t.string   "psu_cd"
    t.integer  "month"
    t.integer  "day"
    t.integer  "zone_nr"
    t.integer  "subregion_nr"
    t.integer  "mapgrid_nr"
    t.integer  "mpa_nr"
    t.integer  "strat_id"
    t.integer  "region_id"
    t.integer  "year_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "psus", ["strat_id"], name: "index_psus_on_strat_id", using: :btree

  create_table "records", force: true do |t|
    t.float    "num"
    t.float    "len"
    t.integer  "time_seen"
    t.integer  "animal_id"
    t.integer  "station_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "records", ["animal_id"], name: "index_records_on_animal_id", using: :btree
  add_index "records", ["station_id"], name: "index_records_on_station_id", using: :btree

  create_table "regions", force: true do |t|
    t.string   "region_cd"
    t.string   "region_name"
    t.integer  "region_nr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stations", force: true do |t|
    t.integer  "station_nr"
    t.float    "lat_degrees"
    t.float    "lon_degrees"
    t.float    "depth"
    t.float    "underwater_visibility"
    t.string   "habitat_cd"
    t.float    "radius",                null: false
    t.integer  "psu_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stations", ["psu_id"], name: "index_stations_on_psu_id", using: :btree

  create_table "strats", force: true do |t|
    t.string   "strat_cd"
    t.text     "strat_description"
    t.boolean  "protected"
    t.integer  "ntot"
    t.integer  "grid_size"
    t.integer  "year_id"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "strats", ["region_id"], name: "index_strats_on_region_id", using: :btree
  add_index "strats", ["year_id"], name: "index_strats_on_year_id", using: :btree

  create_table "years", force: true do |t|
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
