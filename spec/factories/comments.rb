FactoryBot.define do
  factory :comment do
    association :user
    association :item
    comment {"test comment"}
  end
end
