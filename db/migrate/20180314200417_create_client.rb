class CreateClient < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :name, limit: 70, null: false
      t.references :person, polymorphic: true, index: true
      t.timestamps
    end
  end
end
