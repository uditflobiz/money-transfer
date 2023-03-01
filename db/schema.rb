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

ActiveRecord::Schema.define(version: 2023_03_01_093719) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "transaction_histories", force: :cascade do |t|
    t.bigint "sender_wallet_id"
    t.bigint "receiver_wallet_id"
    t.float "amount_debited"
    t.float "amount_credited"
    t.float "transaction_fee"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["receiver_wallet_id"], name: "index_transaction_histories_on_receiver_wallet_id"
    t.index ["sender_wallet_id"], name: "index_transaction_histories_on_sender_wallet_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "aadhaar_number"
    t.string "aadhaar_url"
    t.boolean "kyc_completed"
    t.string "otp_secret_key"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wallets", force: :cascade do |t|
    t.bigint "users_id"
    t.string "currency"
    t.float "amount", default: 0.0
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["users_id"], name: "index_wallets_on_users_id"
  end

  add_foreign_key "transaction_histories", "wallets", column: "receiver_wallet_id"
  add_foreign_key "transaction_histories", "wallets", column: "sender_wallet_id"
end
