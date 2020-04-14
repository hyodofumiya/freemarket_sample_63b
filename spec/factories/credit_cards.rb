FactoryBot.define do
  factory :credit_card do
    association :user

    customer_id {Faker::Code.asin}
    card_id {Faker::Code.nric}

  end
end
