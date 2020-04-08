class ShoppingAddress < ApplicationRecord
  include FullnameAndPhoneAction
  belongs_to :user, optional: true
  
  before_validation :correct_post_cord_number
  validates :post_cord, presence: true, format: {with: /\A\d+\z/, message: I18n.t('errors.messages.not_a_number')}
  validates :prefecture, presence: true
  validates :cities, presence: true
  validates :address, presence: true

  def prefecture
    if super
      return Prefectures.find(super)
    else
      nil
    end
  end

  private
  def correct_post_cord_number
    correct_number("post_cord")
  end
end
