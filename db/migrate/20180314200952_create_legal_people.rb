class CreateLegalPeople < ActiveRecord::Migration[5.1]
  def change
    create_table :legal_people do |t|
      t.string :cnpj, limit: 14
      t.string :social_reason, limit: 70
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
