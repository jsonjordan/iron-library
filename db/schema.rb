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

ActiveRecord::Schema.define(version: 20160629173944) do

  create_table "books", force: :cascade do |t|
    t.string   "isbn"
    t.string   "title"
    t.string   "author"
    t.string   "category",                default: ""
    t.string   "year_of_publication"
    t.string   "status",                  default: "in"
    t.text     "summary"
    t.text     "data"
    t.integer  "campus_id"
    t.string   "gr_rating"
    t.string   "cover_url"
    t.boolean  "confirmed",               default: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "books", ["campus_id"], name: "index_books_on_campus_id"

  create_table "campus", force: :cascade do |t|
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "librarian"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "checkouts", force: :cascade do |t|
    t.datetime "due_date"
    t.integer  "book_id"
    t.integer  "user_id"
    t.integer  "campu_id"
    t.string   "status",     default: "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "checkouts", ["book_id"], name: "index_checkouts_on_book_id"
  add_index "checkouts", ["user_id"], name: "index_checkouts_on_user_id"

  create_table "purchase_requests", force: :cascade do |t|
    t.string   "isbn"
    t.string   "klass"
    t.integer  "user_id"
    t.integer  "campus_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "purchase_requests", ["campus_id"], name: "index_purchase_requests_on_campus_id"
  add_index "purchase_requests", ["user_id"], name: "index_purchase_requests_on_user_id"

  create_table "reservations", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reservations", ["book_id"], name: "index_reservations_on_book_id"
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id"

  create_table "reviews", force: :cascade do |t|
    t.text     "content"
    t.text     "response",   default: nil
    t.integer  "book_id"
    t.string   "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reviews", ["book_id"], name: "index_reviews_on_book_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "slack_name"
    t.string   "gmail_id"
    t.string   "permission",                          default: "student"
    t.string   "klass"
    t.integer  "campus_id"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
