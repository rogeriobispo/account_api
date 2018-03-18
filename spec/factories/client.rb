FactoryBot.define do
  factory :client do
    name FFaker::Lorem.word
    person  { create(:legal_person) }

    trait :phy_person do
      person  { create(:physical_person) }
    end

    trait :leg_person do
      person  { create(:legal_person) }
    end
  end
end
