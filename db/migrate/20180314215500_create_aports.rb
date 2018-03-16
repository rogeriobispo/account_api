class CreateAports < ActiveRecord::Migration[5.1]
  def change
    create_table :aports do |t|
      t.string :code, null: false
      t.references :account_transaction, foreign_key: true, null: false

      t.timestamps
    end
    add_index :aports, :code
  end
end
