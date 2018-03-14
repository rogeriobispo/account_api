class CreateAports < ActiveRecord::Migration[5.1]
  def change
    create_table :aports do |t|
      t.string :code
      t.references :transaction, foreign_key: true

      t.timestamps
    end
    add_index :aports, :code
  end
end
