FactoryBot.define do
  factory :legal_person do
    cnpj CPF.generate
    social_reason FFaker::Company.name
  end
end
