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

ActiveRecord::Schema.define(version: 20140507201212) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "duplicate_stickers", force: true do |t|
    t.integer  "user_id"
    t.integer  "sticker_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "duplicate_stickers", ["sticker_id"], name: "index_duplicate_stickers_on_sticker_id", using: :btree
  add_index "duplicate_stickers", ["user_id"], name: "index_duplicate_stickers_on_user_id", using: :btree

  create_table "needed_stickers", force: true do |t|
    t.integer  "user_id"
    t.integer  "sticker_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "needed_stickers", ["sticker_id"], name: "index_needed_stickers_on_sticker_id", using: :btree
  add_index "needed_stickers", ["user_id"], name: "index_needed_stickers_on_user_id", using: :btree

  create_table "stickers", force: true do |t|
    t.string   "number"
    t.integer  "order"
    t.string   "name"
    t.string   "team"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stickers", ["number"], name: "index_stickers_on_number", unique: true, using: :btree
  add_index "stickers", ["order"], name: "index_stickers_on_order", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "oauth_expires_at"
  end

end
