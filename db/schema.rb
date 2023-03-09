# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_03_09_071948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "currencies", force: :cascade do |t|
    t.string "currency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transaction_histories", force: :cascade do |t|
    t.bigint "sender_wallet_id"
    t.bigint "receiver_wallet_id"
    t.float "amount_debited"
    t.float "amount_credited"
    t.float "transaction_fee"
    t.boolean "wallet_top_up"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["receiver_wallet_id"], name: "index_transaction_histories_on_receiver_wallet_id"
    t.index ["sender_wallet_id"], name: "index_transaction_histories_on_sender_wallet_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "phone_number"
    t.string "aadhaar_number"
    t.string "aadhaar_url"
    t.boolean "kyc_completed"
    t.string "otp_secret_key"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["aadhaar_number"], name: "index_users_on_aadhaar_number", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "currency_id"
    t.float "amount", default: 0.0
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["currency_id"], name: "index_wallets_on_currency_id"
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "transaction_histories", "wallets", column: "receiver_wallet_id"
  add_foreign_key "transaction_histories", "wallets", column: "sender_wallet_id"
end
