FactoryBot.define do
  factory :order do
    association :user
    association :credit_card
    association :item
  end
end
