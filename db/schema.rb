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

ActiveRecord::Schema.define(version: 20170126153258) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entries", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.string   "member_id"
    t.string   "original_raw_image_urls"
    t.string   "original_thumbnail_urls"
    t.string   "uploaded_raw_image_urls"
    t.string   "uploaded_thumbnail_urls"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.text     "published"
    t.datetime "published2"
  end

  create_table "fcms", force: :cascade do |t|
    t.string   "reg_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "name_main"
    t.string   "name_sub"
    t.string   "blog_url"
    t.string   "rss_url"
    t.string   "status"
    t.string   "image_url"
    t.string   "birthday"
    t.string   "blood_type"
    t.string   "constellation"
    t.string   "height"
    t.integer  "favorite"
    t.string   "key"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "objectId"
  end

end
