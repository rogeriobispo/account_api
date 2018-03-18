class LegalPerson < ApplicationRecord
  has_one :client, as: :person
  validates :cnpj, :social_reason, presence: true

  def formated_person
    {
      id: self.client.id,
      name: self.client.name,
      cnpj: self.cnpj,
      social_reason: self.social_reason
    }
  end
end
