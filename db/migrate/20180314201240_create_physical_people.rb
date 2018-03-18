class CreatePhysicalPeople < ActiveRecord::Migration[5.1]
  def change
    create_table :physical_people do |t|
      t.string :cpf, limit: 11, null: false
      t.date :birthdate, null: false

      t.timestamps
    end
  end
end
