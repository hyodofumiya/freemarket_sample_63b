class CreditCard < ApplicationRecord
  belong_to :user
  has_many  :orders
end
