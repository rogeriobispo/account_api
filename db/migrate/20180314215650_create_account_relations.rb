class CreateAccountRelations < ActiveRecord::Migration[5.1]
  def change
    create_table :account_relations do |t|
      t.integer :parent_account_id
      t.integer :subsidiary_account_id

      t.timestamps
    end
    add_index :account_relations, :parent_account_id
    add_index :account_relations, :subsidiary_account_id
  end
end
