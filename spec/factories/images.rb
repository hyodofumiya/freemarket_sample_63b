FactoryBot.define do
  factory :image do
    association :item
    
    photo {open("#{Rails.root}/public/material/icon/icon-search 1.png")}
  end
end
