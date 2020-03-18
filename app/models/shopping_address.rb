class ShoppingAddress < ApplicationRecord
  include FullnameAndPhoneAction
  belongs_to :user
end
