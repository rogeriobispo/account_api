class CreateAccountTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :account_transactions do |t|
      t.integer :origin_account_id, null: false
      t.integer :destiny_account_id, null: false
      t.decimal :amount, precision: 8, scale: 2, null: false

      t.timestamps
    end
    add_index :account_transactions, :origin_account_id
    add_index :account_transactions, :destiny_account_id
  end
end
