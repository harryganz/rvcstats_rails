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

ActiveRecord::Schema.define(version: 20150625163240) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animals", force: true do |t|
    t.string   "species_cd"
    t.string   "sciname"
    t.string   "comname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "animals", ["species_cd"], name: "index_animals_on_species_cd", unique: true, using: :btree

  create_table "domain_diversities", force: true do |t|
    t.string   "region"
    t.integer  "year"
    t.integer  "richness"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "domains", force: true do |t|
    t.integer  "year"
    t.string   "region"
    t.integer  "richness"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parameters", force: true do |t|
    t.float    "length_at_capture"
    t.float    "length_at_maturity"
    t.decimal  "wlen_a"
    t.decimal  "wlen_b"
    t.integer  "animal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "parameters", ["animal_id"], name: "index_parameters_on_animal_id", using: :btree

  create_table "psu_diversities", force: true do |t|
    t.string   "primary_sample_unit"
    t.integer  "strat_diversity_id"
    t.integer  "richness"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "psus", force: true do |t|
    t.integer  "month"
    t.integer  "day"
    t.string   "primary_sample_unit"
    t.integer  "zone_nr"
    t.integer  "subregion_nr"
    t.integer  "mapgrid_nr"
    t.integer  "mpa_nr"
    t.integer  "richness"
    t.integer  "strat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "psus", ["strat_id"], name: "index_psus_on_strat_id", using: :btree

  create_table "samples", force: true do |t|
    t.integer  "time_seen"
    t.float    "num"
    t.float    "len"
    t.integer  "animal_id"
    t.integer  "ssu_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "samples", ["animal_id"], name: "index_samples_on_animal_id", using: :btree
  add_index "samples", ["ssu_id"], name: "index_samples_on_ssu_id", using: :btree

  create_table "ssu_diversities", force: true do |t|
    t.integer  "psu_diversity_id"
    t.integer  "station_nr"
    t.integer  "richness"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ssus", force: true do |t|
    t.integer  "station_nr"
    t.float    "lat_degrees"
    t.float    "lon_degrees"
    t.float    "depth"
    t.float    "underwater_visibility"
    t.string   "habitat_cd"
    t.integer  "richness"
    t.integer  "psu_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "max_hard_relief"
    t.float    "max_soft_relief"
    t.float    "avg_hard_relief"
    t.float    "hard_rel_pct_0"
    t.float    "hard_rel_pct_1"
    t.float    "hard_rel_pct_2"
    t.float    "hard_rel_pct_3"
    t.float    "hard_rel_pct_4"
    t.float    "pct_sand"
    t.float    "pct_hard_bottom"
    t.float    "pct_coral"
    t.float    "pct_octo"
    t.float    "pct_sponge"
  end

  add_index "ssus", ["psu_id"], name: "index_ssus_on_psu_id", using: :btree

  create_table "strat_diversities", force: true do |t|
    t.integer  "strat_id"
    t.integer  "domain_diversity_id"
    t.integer  "richness"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "strats", force: true do |t|
    t.string   "strat"
    t.integer  "prot"
    t.integer  "ntot"
    t.integer  "grid_size"
    t.integer  "richness"
    t.integer  "domain_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rfhab"
    t.integer  "rugosity_cd"
  end

  add_index "strats", ["domain_id"], name: "index_strats_on_domain_id", using: :btree

end
