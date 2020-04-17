class CreditCard < ApplicationRecord
  belongs_to :user
  has_many :orders

  validates :card_id, :customer_id, uniqueness:true, presence: true
end
