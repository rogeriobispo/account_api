class LegalPerson < ApplicationRecord
  belongs_to :person
  validates :person, :cnpj, :social_reason, presence: true
end
