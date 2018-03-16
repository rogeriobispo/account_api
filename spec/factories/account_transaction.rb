FactoryBot.define do
  factory :account_transaction do
    origin_account
    destiny_account
    amount 10.0

    factory :created_account_transaction do
      status 0
    end

    factory :reversed_account_transaction do
      status 1
    end
  end
end
