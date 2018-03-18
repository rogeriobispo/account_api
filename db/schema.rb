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

ActiveRecord::Schema.define(version: 20180318100910) do

  create_table "account_relations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "above_ac_id", null: false
    t.integer "below_ac_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["above_ac_id"], name: "index_account_relations_on_above_ac_id"
    t.index ["below_ac_id"], name: "index_account_relations_on_below_ac_id"
  end

  create_table "account_transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "origin_account_id", null: false
    t.integer "destiny_account_id", null: false
    t.decimal "amount", precision: 8, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["destiny_account_id"], name: "index_account_transactions_on_destiny_account_id"
    t.index ["origin_account_id"], name: "index_account_transactions_on_origin_account_id"
  end

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "status", null: false
    t.integer "kind", null: false
    t.bigint "client_id", null: false
    t.decimal "amount_holded", precision: 8, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_accounts_on_client_id"
  end

  create_table "aports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code", null: false
    t.bigint "account_transaction_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_transaction_id"], name: "index_aports_on_account_transaction_id"
    t.index ["code"], name: "index_aports_on_code"
  end

  create_table "clients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 70, null: false
    t.string "person_type"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["person_type", "person_id"], name: "index_clients_on_person_type_and_person_id"
  end

  create_table "legal_people", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "cnpj", limit: 14, null: false
    t.string "social_reason", limit: 70, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "physical_people", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "cpf", limit: 11, null: false
    t.date "birthdate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "accounts", "clients"
  add_foreign_key "aports", "account_transactions"
end
