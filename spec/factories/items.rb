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
  end
end
