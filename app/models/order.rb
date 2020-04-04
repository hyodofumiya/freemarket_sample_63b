class Order < ApplicationRecord
  belong_to :user
  belong_to :credit_card
  belong_ro :item
end
