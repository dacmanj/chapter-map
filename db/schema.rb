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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130703152630) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "chapters", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "email_1"
    t.string   "email_2"
    t.string   "email_3"
    t.string   "helpline"
    t.string   "phone_1"
    t.string   "phone_2"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "ein"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.boolean  "gmaps"
    t.string   "gmaps_address"
    t.integer  "radius"
    t.string   "category"
    t.boolean  "separate_exemption"
    t.boolean  "inactive"
    t.string   "database_identifier"
    t.string   "chapter_legacy_identifier"
  end

  create_table "chapters_users", :force => true do |t|
    t.integer "chapter_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.boolean  "admin"
    t.string   "password_digest"
    t.string   "activation_code"
  end

end
