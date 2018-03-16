FactoryBot.define do
  factory :aport do
    code SecureRandom.hex(15)
    account_transaction
  end
end
