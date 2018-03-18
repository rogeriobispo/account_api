class PhysicalPerson < ApplicationRecord
  has_one :client
  has_one :client, as: :person
  validates :cpf, :birthdate, presence: true

  def formated_person
    {
      id: self.client.id,
      name: self.client.name,
      cpf: self.cpf,
      birthdate: self.birthdate
     }
  end
end
