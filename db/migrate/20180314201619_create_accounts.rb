class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :name, limit: 70
      t.integer :status
      t.integer :kind
      t.references :person, foreign_key: true
      t.decimal :amount_holded

      t.timestamps
    end
  end
end
