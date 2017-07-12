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

ActiveRecord::Schema.define(version: 20170710091135) do

  create_table "brand_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer  "user_id",                                      null: false
    t.string   "name",                            default: "", null: false
    t.integer  "logo",                                         null: false
    t.integer  "brand_category_id",               default: 0,  null: false
    t.string   "place",                                        null: false
    t.string   "leader",                          default: "", null: false
    t.integer  "tel",                             default: 0,  null: false
    t.integer  "tel_code"
    t.integer  "business_licence",                             null: false
    t.text     "business_scope",    limit: 65535,              null: false
    t.text     "content",           limit: 65535,              null: false
    t.integer  "check_flag",                      default: 0,  null: false
    t.integer  "status"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["check_flag"], name: "index_brands_on_check_flag", using: :btree
    t.index ["user_id"], name: "index_brands_on_user_id", using: :btree
  end

  create_table "user_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer  "user_id"
    t.string   "user_name"
    t.string   "motto"
    t.string   "category"
    t.string   "address"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["user_id"], name: "index_user_profiles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string   "user_name",           limit: 20
    t.string   "phone",               limit: 20
    t.string   "password_digest"
    t.string   "remeber_digest"
    t.bigint   "user_type"
    t.string   "verification_digest"
    t.integer  "verification_limit",  limit: 2,  default: 0
    t.datetime "verification_time"
    t.integer  "is_verify",           limit: 2,  default: 0
    t.integer  "status",              limit: 2,  default: 1
    t.string   "ip",                  limit: 20
    t.datetime "login_at"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

end
