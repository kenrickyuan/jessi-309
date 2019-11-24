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

ActiveRecord::Schema.define(version: 2019_11_21_182519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.string "location"
    t.date "start_time"
    t.date "end_time"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.bigint "event_id"
    t.string "description"
    t.integer "amount_cents", default: 0, null: false
    t.bigint "guest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_expenses_on_event_id"
    t.index ["guest_id"], name: "index_expenses_on_guest_id"
  end

  create_table "fields", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "poll_id"
    t.string "title"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guests", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_guests_on_event_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "expense_id"
    t.bigint "payer_id"
    t.bigint "payee_id"
    t.integer "amount_cents", default: 0, null: false
    t.boolean "is_debt", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_id"], name: "index_transactions_on_expense_id"
    t.index ["payee_id"], name: "index_transactions_on_payee_id"
    t.index ["payer_id"], name: "index_transactions_on_payer_id"
  end

  create_table "polls", force: :cascade do |t|
    t.string "typeform_id"
    t.bigint "event_id"
    t.string "link"
    t.string "form_title"
    t.string "question"
    t.string "option"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_polls_on_event_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "expenses", "events"
  add_foreign_key "expenses", "guests"
  add_foreign_key "guests", "events"
  add_foreign_key "transactions", "expenses"
  add_foreign_key "transactions", "guests", column: "payee_id"
  add_foreign_key "transactions", "guests", column: "payer_id"
  add_foreign_key "polls", "events"
  add_foreign_key "fields", "events"
  add_foreign_key "fields", "polls"
end
