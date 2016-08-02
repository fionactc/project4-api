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

ActiveRecord::Schema.define(version: 20160802064725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agent_ratings", force: :cascade do |t|
    t.integer  "ar_overall_star"
    t.text     "ar_commment"
    t.integer  "agent_id"
    t.integer  "renter_id"
    t.integer  "appointment_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "agents", force: :cascade do |t|
    t.string   "provider",                  default: "email", null: false
    t.string   "uid",                       default: "",      null: false
    t.string   "encrypted_password",        default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "salutation"
    t.string   "first_name"
    t.string   "family_name"
    t.string   "mobile_number"
    t.float    "agent_avg_ratings"
    t.string   "website"
    t.text     "description"
    t.string   "license_num"
    t.string   "company_website"
    t.string   "company_license_num"
    t.string   "branch_address"
    t.string   "branch_phone"
    t.string   "branch_fax"
    t.string   "gen_vtoken"
    t.boolean  "is_verified"
    t.string   "license_file_file_name"
    t.string   "license_file_content_type"
    t.integer  "license_file_file_size"
    t.datetime "license_file_updated_at"
    t.string   "company_logo_file_name"
    t.string   "company_logo_content_type"
    t.integer  "company_logo_file_size"
    t.datetime "company_logo_updated_at"
    t.string   "regions",                                                  array: true
    t.index ["company_license_num"], name: "index_agents_on_company_license_num", unique: true, using: :btree
    t.index ["email"], name: "index_agents_on_email", using: :btree
    t.index ["license_num"], name: "index_agents_on_license_num", unique: true, using: :btree
    t.index ["mobile_number"], name: "index_agents_on_mobile_number", unique: true, using: :btree
    t.index ["regions"], name: "index_agents_on_regions", using: :btree
    t.index ["reset_password_token"], name: "index_agents_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_agents_on_uid_and_provider", unique: true, using: :btree
  end

  create_table "apartment_pictures", force: :cascade do |t|
    t.integer  "apartment_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "apartments", force: :cascade do |t|
    t.string   "apt_name"
    t.string   "street"
    t.string   "area"
    t.integer  "property_size_gross_min"
    t.integer  "property_size_gross_max"
    t.integer  "property_size_net_min"
    t.integer  "property_size_net_max"
    t.integer  "price"
    t.integer  "bedroom_num"
    t.integer  "bathroom_num"
    t.boolean  "pet_friendly"
    t.string   "facilities"
    t.string   "building_type"
    t.string   "description"
    t.integer  "agent_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "appointments", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.time     "start_time"
    t.time     "end_time"
    t.boolean  "read"
    t.integer  "agent_rating_id"
    t.integer  "renter_rating_id"
    t.integer  "enquiry_agent_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "chats", force: :cascade do |t|
    t.string   "title"
    t.integer  "enquiry_agent_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "agent_id"
    t.string   "renter_id"
  end

  create_table "enquiries", force: :cascade do |t|
    t.string   "region"
    t.string   "area"
    t.integer  "bedroom_num"
    t.integer  "bathroom_num"
    t.integer  "property_size_min"
    t.integer  "property_size_max"
    t.integer  "price_min"
    t.integer  "price_max"
    t.string   "building_type"
    t.string   "timeslot_1_date"
    t.time     "timeslot_1_time"
    t.string   "timeslot_2_date"
    t.time     "timeslot_2_time"
    t.boolean  "archived"
    t.integer  "renter_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "enquiry_agents", force: :cascade do |t|
    t.boolean  "is_blocked"
    t.integer  "agent_id"
    t.integer  "enquiry_id"
    t.integer  "chat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "chat_id"
    t.integer  "agent_id"
    t.integer  "renter_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.index ["imageable_type", "imageable_id"], name: "index_messages_on_imageable_type_and_imageable_id", using: :btree
  end

  create_table "property_listings", force: :cascade do |t|
    t.boolean  "like"
    t.integer  "apartment_id"
    t.integer  "enquiry_agent_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "renter_ratings", force: :cascade do |t|
    t.integer  "rr_overall_star"
    t.text     "rr_comment"
    t.boolean  "no_show"
    t.boolean  "spy"
    t.integer  "agent_id"
    t.integer  "renter_id"
    t.integer  "appointment_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "renters", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "salutation"
    t.string   "first_name"
    t.string   "family_name"
    t.string   "mobile_number"
    t.float    "renter_avg_ratings"
    t.date     "birthday"
    t.string   "gender"
    t.string   "occupation"
    t.boolean  "pet"
    t.boolean  "english"
    t.boolean  "is_admin"
    t.string   "gen_vtoken"
    t.boolean  "is_verified"
    t.index ["email"], name: "index_renters_on_email", using: :btree
    t.index ["mobile_number"], name: "index_renters_on_mobile_number", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_renters_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_renters_on_uid_and_provider", unique: true, using: :btree
  end

end
