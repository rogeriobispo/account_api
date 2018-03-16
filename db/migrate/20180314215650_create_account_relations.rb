class CreateAccountRelations < ActiveRecord::Migration[5.1]
  def change
    create_table :account_relations do |t|
      t.integer :above_ac_id, null: false
      t.integer :below_ac_id, null: false

      t.timestamps
    end
    add_index :account_relations, :above_ac_id
    add_index :account_relations, :below_ac_id
  end
end
