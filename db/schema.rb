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

ActiveRecord::Schema.define(version: 20141108145039) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: true do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "chapter_id"
    t.string   "tag",                     limit: 255
  end

  create_table "attachments", force: true do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "chapter_id"
    t.string   "tag",                     limit: 255
    t.integer  "user_id"
  end

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "chapter_leaders", force: true do |t|
    t.integer  "chapter_id"
    t.integer  "member_id"
    t.string   "position",                  limit: 255
    t.string   "spouse_position",           limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "position_import_id",        limit: 255
    t.string   "spouse_position_import_id", limit: 255
  end

  create_table "chapters", force: true do |t|
    t.string   "name",                   limit: 255
    t.string   "website",                limit: 255
    t.string   "street",                 limit: 255
    t.string   "city",                   limit: 255
    t.string   "state",                  limit: 255
    t.string   "zip",                    limit: 255
    t.string   "email_1",                limit: 255
    t.string   "email_2",                limit: 255
    t.string   "email_3",                limit: 255
    t.string   "helpline",               limit: 255
    t.string   "phone_1",                limit: 255
    t.string   "phone_2",                limit: 255
    t.float    "latitude"
    t.float    "longitude"
    t.string   "ein",                    limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "gmaps"
    t.string   "gmaps_address",          limit: 255
    t.integer  "radius"
    t.string   "category",               limit: 255
    t.boolean  "separate_exemption"
    t.boolean  "inactive"
    t.string   "database_identifier",    limit: 255
    t.string   "email_1_import_id",      limit: 255
    t.string   "email_2_import_id",      limit: 255
    t.string   "email_3_import_id",      limit: 255
    t.string   "helpline_import_id",     limit: 255
    t.string   "phone_1_import_id",      limit: 255
    t.string   "phone_2_import_id",      limit: 255
    t.string   "address_import_id",      limit: 255
    t.string   "independent_import_id",  limit: 255
    t.string   "ein_import_id",          limit: 255
    t.boolean  "revoked"
    t.date     "revocation_date"
    t.boolean  "position_lock"
    t.boolean  "ambiguate_address"
    t.string   "twitter_url",            limit: 255
    t.string   "twitter_url_import_id",  limit: 255
    t.string   "facebook_url",           limit: 255
    t.string   "facebook_url_import_id", limit: 255
    t.string   "website_import_id",      limit: 255
    t.boolean  "pending"
    t.string   "pending_reason",         limit: 255
  end

  create_table "chapters_users", force: true do |t|
    t.integer "chapter_id"
    t.integer "user_id"
  end

  create_table "leaders", force: true do |t|
    t.string   "contituent_id",           limit: 255
    t.string   "first_name",              limit: 255
    t.string   "last_name",               limit: 255
    t.string   "chapter_code",            limit: 255
    t.string   "spouse_first_name",       limit: 255
    t.string   "spouse_last_name",        limit: 255
    t.string   "address",                 limit: 255
    t.string   "address_2",               limit: 255
    t.string   "city",                    limit: 255
    t.string   "state",                   limit: 255
    t.string   "zip",                     limit: 255
    t.string   "phone",                   limit: 255
    t.string   "email",                   limit: 255
    t.string   "address_import_id",       limit: 255
    t.string   "phone_import_id",         limit: 255
    t.string   "email_import_id",         limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "suppress_from_directory"
    t.integer  "chapter_id"
  end

  create_table "members", force: true do |t|
    t.string   "contituent_id",           limit: 255
    t.string   "first_name",              limit: 255
    t.string   "last_name",               limit: 255
    t.string   "chapter_code",            limit: 255
    t.string   "spouse_first_name",       limit: 255
    t.string   "spouse_last_name",        limit: 255
    t.string   "address",                 limit: 255
    t.string   "city",                    limit: 255
    t.string   "state",                   limit: 255
    t.string   "zip",                     limit: 255
    t.string   "phone",                   limit: 255
    t.string   "email",                   limit: 255
    t.string   "address_import_id",       limit: 255
    t.string   "phone_import_id",         limit: 255
    t.string   "email_import_id",         limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "suppress_from_directory"
    t.integer  "chapter_id"
    t.string   "import_id",               limit: 255
  end

  create_table "roles", force: true do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id"
    t.string   "resource_type", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "users", force: true do |t|
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255, default: "", null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.boolean  "override_sync"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  limit: 255, null: false
    t.integer  "item_id",                null: false
    t.string   "event",      limit: 255, null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
