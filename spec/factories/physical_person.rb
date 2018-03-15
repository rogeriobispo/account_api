FactoryBot.define do
  factory :physical_person do
    cpf Faker::CPF.numeric
    birthdate '1983-11-08'.to_date
    person
  end
end
