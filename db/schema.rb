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

ActiveRecord::Schema.define(:version => 20131023023528) do

  create_table "Attachments", :force => true do |t|
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "chapter_id"
    t.string   "tag"
  end

  create_table "assets", :force => true do |t|
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "chapter_id"
    t.string   "tag"
  end

  create_table "attachments", :force => true do |t|
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "chapter_id"
    t.string   "tag"
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "chapter_leaders", :force => true do |t|
    t.integer  "chapter_id"
    t.integer  "leader_id"
    t.string   "position_1"
    t.string   "position_2"
    t.string   "position_3"
    t.string   "position_4"
    t.string   "position_5"
    t.string   "spouse_position_1"
    t.string   "spouse_position_2"
    t.string   "spouse_position_3"
    t.string   "spouse_position_4"
    t.string   "spouse_position_5"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
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
    t.string   "bylaws_file_name"
    t.string   "bylaws_content_type"
    t.integer  "bylaws_file_size"
    t.datetime "bylaws_updated_at"
    t.string   "email_1_import_id"
    t.string   "email_2_import_id"
    t.string   "email_3_import_id"
    t.string   "helpline_import_id"
    t.string   "phone_1_import_id"
    t.string   "phone_2_import_id"
    t.string   "address_import_id"
    t.string   "independent_import_id"
    t.string   "ein_import_id"
  end

  create_table "chapters_users", :force => true do |t|
    t.integer "chapter_id"
    t.integer "user_id"
  end

  create_table "leaders", :force => true do |t|
    t.string   "contituent_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "chapter_code"
    t.string   "spouse_first_name"
    t.string   "spouse_last_name"
    t.string   "address"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.string   "address_import_id"
    t.string   "phone_import_id"
    t.string   "email_import_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.boolean  "suppress_from_directory"
    t.integer  "chapter_id"
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

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
