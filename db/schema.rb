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

ActiveRecord::Schema.define(version: 20170724160036) do

  create_table "brand_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brand_uploads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "upload_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "brands", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "user_id",                                      null: false
    t.string   "name",                            default: "", null: false
    t.string   "logo"
    t.integer  "brand_category_id",               default: 0,  null: false
    t.string   "province",          limit: 50
    t.string   "city",              limit: 50
    t.string   "district",          limit: 50
    t.string   "detail_address",    limit: 80
    t.string   "leader",                          default: "", null: false
    t.integer  "tel",                                          null: false
    t.integer  "tel_code"
    t.text     "business_scope",    limit: 65535,              null: false
    t.string   "licence"
    t.text     "content",           limit: 65535,              null: false
    t.integer  "check_flag",                      default: 0,  null: false
    t.integer  "status"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["check_flag"], name: "index_brands_on_check_flag", using: :btree
    t.index ["user_id"], name: "index_brands_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "title",           limit: 100
    t.string   "province",        limit: 50
    t.string   "city",            limit: 50
    t.string   "district",        limit: 50
    t.string   "detail_address",  limit: 80
    t.string   "building",        limit: 30
    t.integer  "room_cnt"
    t.integer  "living_room_cnt"
    t.integer  "toilet_cnt"
    t.integer  "kitchen_cnt"
    t.integer  "home_size"
    t.text     "content",         limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "user_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "user_id"
    t.string   "user_name"
    t.string   "motto"
    t.string   "province",            limit: 50
    t.string   "city",                limit: 50
    t.string   "district",            limit: 50
    t.string   "detail_address",      limit: 80
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["user_id"], name: "index_user_profiles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "phone",               limit: 20
    t.string   "password_digest"
    t.string   "remeber_digest"
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
