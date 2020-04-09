FactoryBot.define do
  factory :shopping_address do
    association :user
    
    gimei = Gimei.name
    family_name {gimei.last.kanji}
    first_name {gimei.first.kanji}
    family_name_kana {gimei.last.katakana}
    first_name_kana {gimei.first.katakana}
    phone_number {Faker::Number.leading_zero_number(digits: 11)}

    new_address = Gimei.address
    post_cord {Faker::Number.leading_zero_number(digits: 7)}
    prefecture {Faker::Number.between(from: 0, to: 46)}
    cities {new_address.city.kanji}
    address {new_address.town.kanji}
    building_name {"コーポ山谷102"}
  end
end
