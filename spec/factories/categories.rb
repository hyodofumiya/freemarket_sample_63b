FactoryBot.define do
  factory :category do
    
    factory :parent, class: Category do
      id {1}
      name {"レディース"}
      size {0}
      ancestory {""}
    end

    factory :child, class: Category do
      id {2}
      name {"トップス"}
      size {0}
      ancestory {1}
    end

    factory :sizegrandchild, class: Category do
      id {3}
      name {"Tシャツ/カットソー"}
      size {1}
      ancestory {1/2}
    end

    factory :nosizegrandchild, class: Category do
      id {4}
      name {"子カテゴリーサイズなし"}
      size {0}
      ancestory {1/2}
    end

  end
end
