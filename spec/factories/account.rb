FactoryBot.define do
  factory :account do
    status 1
    kind 1
    person

    factory :origin_account do
      after(:create) do |ac|
        ac.credit(5000.00)
      end
    end

    factory :destiny_account do
      person
      after(:create) do |ac|
        ac.credit(4000.00)
      end
    end

    factory :parent_account do
      person
      after(:create) do |ac|
        ac.credit(5000.00)
      end
    end

    factory :subsidiary_account do
      person
      after(:create) do |ac|
        ac.credit(4000.00)
      end
    end

    factory :account_with_100 do
      after(:create) do |ac|
        ac.credit(100.00)
      end
    end
  end
end
