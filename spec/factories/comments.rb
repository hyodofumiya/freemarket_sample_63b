FactoryBot.define do
  factory :comment do
    association :user
    association :item
    comment {Faker::Lorem.characters(number: 254)}
  end
end
