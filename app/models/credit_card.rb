class CreditCard < ApplicationRecord
  belongs_to :user
  has_many :orders

  validates :user_id, uniqueness: true
  validates :card_id, :customer_id, uniqueness:true, presence: true
end
