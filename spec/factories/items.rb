FactoryBot.define do
  factory :item do
    association :user
    # association :category
    association :brand
    name { "testItem" }
    discription { "created for test" }
    size {0}
    condition {0}
    delivary {0}
    area { Gimei.prefecture.kanji }
    preparation_day {6}
    price { 5000 }
    status { true }
    after(:build){ |item| item.images << build(:image)}
  end

  factory :noneImageItem, class: Item do
    association :user
    association :category
    name { Faker::Lorem.characters(number: 254) }
    discription { Faker::Lorem.characters }
    size {Item::SIZE.keys.sample.to_i}
    condition {Item::CONDITION.keys.sample.to_i}
    delivary {Item::DELIVARY.keys.sample.to_i}
    area { Gimei.prefecture.kanji }
    preparation_day {Random.rand(100)}
    price { Random.rand(1000000)+1 }
    status { true }
  end
end
