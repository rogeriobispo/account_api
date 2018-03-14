class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer :origin_account_id
      t.integer :destiny_account_id
      t.decimal :amount

      t.timestamps
    end
    add_index :transactions, :origin_account_id
    add_index :transactions, :destiny_account_id
  end
end
