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

ActiveRecord::Schema.define(version: 20180314215650) do

  create_table "account_relations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "parent_account_id"
    t.integer "subsidiary_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_account_id"], name: "index_account_relations_on_parent_account_id"
    t.index ["subsidiary_account_id"], name: "index_account_relations_on_subsidiary_account_id"
  end

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 70
    t.integer "status"
    t.integer "kind"
    t.bigint "person_id"
    t.decimal "amount_holded", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_accounts_on_person_id"
  end

  create_table "aports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code"
    t.bigint "transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_aports_on_code"
    t.index ["transaction_id"], name: "index_aports_on_transaction_id"
  end

  create_table "legal_people", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "cnpj", limit: 14
    t.string "social_reason", limit: 70
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_legal_people_on_person_id"
  end

  create_table "people", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 70
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "physical_people", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "cpf", limit: 11
    t.date "birthdate"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_physical_people_on_person_id"
  end

  create_table "transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "origin_account_id"
    t.integer "destiny_account_id"
    t.decimal "amount", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destiny_account_id"], name: "index_transactions_on_destiny_account_id"
    t.index ["origin_account_id"], name: "index_transactions_on_origin_account_id"
  end

  add_foreign_key "accounts", "people"
  add_foreign_key "aports", "transactions"
  add_foreign_key "legal_people", "people"
  add_foreign_key "physical_people", "people"
end
