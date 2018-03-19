FactoryBot.define do
  factory :account do
    status 0
    kind 1
    client { create(:client, :phy_person) }

    factory :origin_account do
      after(:create) do |ac|
        ac.credit(5000.00)
      end
    end

    factory :destiny_account do
      client { create(:client, :phy_person) }
      after(:create) do |ac|
        ac.credit(4000.00)
      end
    end

    factory :parent_account do
      client { create(:client, :leg_person) }
      kind 0
      after(:create) do |ac|
        ac.credit(5000.00)
      end
    end

    factory :subsidiary_account do
      after(:create) do |ac|
        ac.credit(4000.00)
      end
    end

    factory :account_with_100 do
      after(:create) do |ac|
        ac.credit(100.00)
      end
    end

    factory :active_account do
      status 0
    end

    factory :blocked_account do
      status 1
    end

    factory :canceled_account do
      status 2
    end
  end
end
