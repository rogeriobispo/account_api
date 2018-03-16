class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.integer :status, null: false
      t.integer :kind, null: false
      t.references :person, foreign_key: true, null: false
      t.decimal :amount_holded, precision: 8, scale: 2, null: false, default: 0.0

      t.timestamps
    end
  end
end
