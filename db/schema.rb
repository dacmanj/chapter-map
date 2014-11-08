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

  create_table "Attachments", force: true do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "chapter_id"
    t.string   "tag"
  end

  create_table "applications", force: true do |t|
    t.string   "phone"
    t.date     "date_of_birth"
    t.date     "date_of_graduation"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "are_you_a_graduating_high_school_senior"
    t.boolean  "out_and_open"
    t.boolean  "identify_supporter"
    t.boolean  "supportive_parents"
    t.string   "how_did_you_learn_about_the_scholarship"
    t.string   "name_of_high_school"
    t.string   "hs_street_address"
    t.string   "hs_city"
    t.string   "hs_state"
    t.string   "hs_zip"
    t.string   "cumulative_gpa"
    t.text     "please_lists_schools_where_you_will_be_applying"
    t.text     "describe_community_service_activities"
    t.text     "essay"
    t.boolean  "release_high_school"
    t.boolean  "release_local_media"
    t.boolean  "release_national_media"
    t.boolean  "release_local_chapter"
    t.boolean  "release_photograph"
    t.boolean  "release_essay_collection"
    t.boolean  "release_picture_bio_on_website"
    t.datetime "signature_stamp"
    t.string   "signature_ip"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.text     "honors_or_awards"
    t.boolean  "identify_lgbt"
    t.boolean  "stem"
    t.string   "major"
    t.string   "admission_status"
    t.text     "employment_history"
    t.string   "how_did_you_learn_explanation"
    t.string   "transcript_file_name"
    t.string   "transcript_content_type"
    t.integer  "transcript_file_size"
    t.datetime "transcript_updated_at"
    t.integer  "applicant_user_id"
    t.boolean  "first_generation"
    t.boolean  "release_application_to_chapter"
    t.text     "why_do_you_want"
  end

  create_table "applications_users", force: true do |t|
    t.integer "application_id"
    t.integer "user_id"
  end

  create_table "assets", force: true do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "chapter_id"
    t.string   "tag"
  end

  create_table "attachments", force: true do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "chapter_id"
    t.string   "tag"
    t.integer  "user_id"
  end

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapter_leaders", force: true do |t|
    t.integer  "chapter_id"
    t.integer  "member_id"
    t.string   "position"
    t.string   "spouse_position"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "position_import_id"
    t.string   "spouse_position_import_id"
  end

  create_table "chapters", force: true do |t|
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
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.boolean  "gmaps"
    t.string   "gmaps_address"
    t.integer  "radius"
    t.string   "category"
    t.boolean  "separate_exemption"
    t.boolean  "inactive"
    t.string   "database_identifier"
    t.string   "email_1_import_id"
    t.string   "email_2_import_id"
    t.string   "email_3_import_id"
    t.string   "helpline_import_id"
    t.string   "phone_1_import_id"
    t.string   "phone_2_import_id"
    t.string   "address_import_id"
    t.string   "independent_import_id"
    t.string   "ein_import_id"
    t.boolean  "revoked"
    t.date     "revocation_date"
    t.boolean  "position_lock"
    t.boolean  "ambiguate_address"
    t.string   "twitter_url"
    t.string   "twitter_url_import_id"
    t.string   "facebook_url"
    t.string   "facebook_url_import_id"
    t.string   "website_import_id"
    t.boolean  "pending"
    t.string   "pending_reason"
  end

  create_table "chapters_users", force: true do |t|
    t.integer "chapter_id"
    t.integer "user_id"
  end

  create_table "leaders", force: true do |t|
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
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.boolean  "suppress_from_directory"
    t.integer  "chapter_id"
  end

  create_table "members", force: true do |t|
    t.string   "contituent_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "chapter_code"
    t.string   "spouse_first_name"
    t.string   "spouse_last_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.string   "address_import_id"
    t.string   "phone_import_id"
    t.string   "email_import_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.boolean  "suppress_from_directory"
    t.integer  "chapter_id"
    t.string   "import_id"
  end

  create_table "references", force: true do |t|
    t.integer  "application_id"
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "how_long_have_you_known"
    t.text     "relationship"
    t.text     "references_essay"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "user_id"
    t.datetime "completed"
    t.string   "token"
    t.integer  "maturity"
    t.integer  "leadership_ability"
    t.integer  "self_confidence"
    t.integer  "self_awareness"
    t.integer  "intellectual_curiosity"
    t.integer  "initiative"
    t.integer  "adaptability"
    t.integer  "personal_integrity"
    t.integer  "respect_for_different_viewpoints"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "scores", force: true do |t|
    t.integer  "application_id"
    t.integer  "user_id"
    t.boolean  "lgbt"
    t.boolean  "ally"
    t.boolean  "stem"
    t.boolean  "community_college"
    t.integer  "essay"
    t.integer  "academics"
    t.integer  "activities"
    t.integer  "lgbt_advocacy"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "discretionary"
    t.decimal  "total"
    t.text     "essay_comment"
    t.text     "academics_comment"
    t.text     "activities_comment"
    t.integer  "reference"
    t.text     "lgbt_advocacy_comment"
    t.text     "discretionary_comment"
    t.text     "reference_comment"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
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
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
