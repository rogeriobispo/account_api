class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :name, limit: 70, null: false

      t.timestamps
    end
  end
end
