class CreatePhysicalPeople < ActiveRecord::Migration[5.1]
  def change
    create_table :physical_people do |t|
      t.string :cpf, limit: 11
      t.date :birthdate
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
