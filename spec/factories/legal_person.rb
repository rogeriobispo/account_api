FactoryBot.define do
  factory :legal_person do
   cnpj Faker::CNPJ.numeric
   social_reason FFaker::Company.name
   person
  end
end

