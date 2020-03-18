FactoryBot.define do                                
    factory :user do
        gimei = Gimei.name
        nickname {Faker::Name.name}
        family_name {gimei.last.kanji}
        first_name {gimei.first.kanji}
        family_name_kana {gimei.last.katakana}
        first_name_kana {gimei.first.katakana}

        password_temp = Faker::Internet.password(min_length: 6)
        password {password_temp}
        password_confirmation {password_temp}

        email {Faker::Internet.email}

        birthday {Faker::Date.birthday(min_age: 1, max_age: 99)}
        phone_number {Faker::Number.leading_zero_number(digits: 11)}
    end                                            
end         