class PhysicalPerson < ApplicationRecord
  belongs_to :person
  validate :cpf, :person, :birthdate, presence: true
end
