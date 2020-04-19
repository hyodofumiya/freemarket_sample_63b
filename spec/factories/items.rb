FactoryBot.define do
  factory :item do
    association :user
    # association :category
    association :brand
    name { Faker::Lorem.characters(number: 254) }
    discription { Faker::Lorem.characters }
    size {Item::SIZE.keys.sample.to_i}
    condition {Item::CONDITION.keys.sample.to_i}
    delivary {Item::DELIVARY.keys.sample.to_i}
    area { Gimei.prefecture.kanji }
    preparation_day {Random.rand(100)}
    price { Random.rand(1000000)+1 }
    after(:build){ |item| item.images << build(:image)}
  end

  factory :noneImageItem, class: Item do
    association :user
    association :brand
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
