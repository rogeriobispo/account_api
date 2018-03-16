class PhysicalPerson < ApplicationRecord
  belongs_to :person
  validates :cpf, :person, :birthdate, presence: true
end
