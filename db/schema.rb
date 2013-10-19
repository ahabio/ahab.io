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

ActiveRecord::Schema.define(version: 20131019203516) do

  create_table "asset_versions", force: true do |t|
    t.integer "value",    null: false
    t.integer "asset_id", null: false
  end

  create_table "assets", force: true do |t|
    t.string "name",        null: false
    t.string "homepage"
    t.string "description"
  end

end