class Order < ApplicationRecord
  belongs_to :user
  belongs_to :credit_card
  belongs_to :item
  
  validates :item_id, uniqueness: true
end
