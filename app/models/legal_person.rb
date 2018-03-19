class LegalPerson < ApplicationRecord
  has_one :client, as: :person
  validates :cnpj, :social_reason, presence: true

  def formated_person
    {
      id: client.id,
      name: client.name,
      cnpj: cnpj,
      social_reason: social_reason
    }
  end
end
