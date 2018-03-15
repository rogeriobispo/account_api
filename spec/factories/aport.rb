FactoryBot.define do
  factory :aport do
    code SecureRandom.hex(15)
    transaction
  end
end
