class PhysicalPerson < ApplicationRecord
  has_one :client
  has_one :client, as: :person
  validates :cpf, :birthdate, presence: true

  def formated_person
    {
      id: client.id,
      name: client.name,
      cpf: cpf,
      birthdate: birthdate
    }
  end
end
