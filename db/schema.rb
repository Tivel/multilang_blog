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

ActiveRecord::Schema.define(version: 20170811161338) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "user_id"
    t.string   "path",                default: "",    null: false
    t.integer  "destination",         default: 0,     null: false
    t.string   "color",               default: ""
    t.string   "english_name"
    t.text     "english_description"
    t.boolean  "black_arrow",         default: false
    t.integer  "priority",            default: 0
    t.boolean  "no_typewrite",        default: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "categories_images", force: :cascade do |t|
    t.integer "category_id"
    t.integer "image_id"
    t.index ["category_id"], name: "index_categories_images_on_category_id"
    t.index ["image_id"], name: "index_categories_images_on_image_id"
  end

  create_table "images", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "file",       null: false
  end

  create_table "images_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "image_id"
    t.index ["image_id"], name: "index_images_users_on_image_id"
    t.index ["user_id"], name: "index_images_users_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "name"
    t.text     "content",                     null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "category_id"
    t.string   "english_name"
    t.text     "english_content"
    t.integer  "priority",        default: 0
    t.index ["category_id"], name: "index_posts_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.text     "custom_css"
    t.string   "persistence_token"
    t.boolean  "admin",             default: false
    t.boolean  "member",            default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["persistence_token"], name: "index_users_on_persistence_token", unique: true
  end

end
