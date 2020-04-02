FactoryBot.define do
  factory :item do
    association :user
    name { "testItem" }
    discription { "created for test" }
    size {0}
    condition {0}
    delivary {0}
    area { "東海" }
    preparation_day {6}
    price { 5000 }
    status { true }
  end
end
