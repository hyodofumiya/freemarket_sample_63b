class Category < ApplicationRecord
  
  has_ancestry
  has_many :items
  #has_many :brands, through: brand_categories
  #has_many :brand_categories
end
