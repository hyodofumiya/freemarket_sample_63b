class Item < ApplicationRecord
  has_many :images
  validates :image, presence: true
  validates :discription, presence: true
  validates :category_id, presence: true
  validates :bland_id, presence: true
  validates :condition, presence: true
  validates :delivary_fee, presence: true
  validates :area, presence: true
  validates :preparation_day, presence: true
  validates :price, presence: true
  validates :status, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end