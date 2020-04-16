class Category < ApplicationRecord
  
  has_ancestry
  has_many :items

  DISPLAY_TOP_PAGE = [1, 199, 891, 477]#ルートカテゴリを表示順に配列に入れる。
  #1: レディース, 199: メンズ, 891: 家電, 477: インテリア

end
