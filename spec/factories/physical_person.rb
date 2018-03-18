FactoryBot.define do
  factory :physical_person do
    cpf CPF.generate
    birthdate '1983-11-08'.to_date
  end
end
