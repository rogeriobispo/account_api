class CreateLegalPeople < ActiveRecord::Migration[5.1]
  def change
    create_table :legal_people do |t|
      t.string :cnpj, limit: 14, null: false
      t.string :social_reason, limit: 70, null: false

      t.timestamps
    end
  end
end
