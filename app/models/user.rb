class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include FullnameAndPhoneAction

  has_many :credit_cards
  has_many :items
  has_many :shopping_addresses
  before_validation :create_birthday, if: :birthday_year && :birthday_month && :birthday_day

  validates :nickname, presence: true
  validates :email, presence: true, uniqueness: true, format: {with: /\w+@\w+/, message: I18n.t('errors.messages.invalid')}
  validates :password, presence: true, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :birthday, presence: true
  
  def birthday_year=(year)
    @year = year
  end

  def birthday_month=(month)
    @month = month
  end

  def birthday_day=(day)
    @day = day
  end

  def birthday_year
    return @year if @year
    self.birthday&.year
  end

  def birthday_month
    return @month if @month
    self.birthday&.month
  end

  def birthday_day
    return @day if @day
    self.birthday&.day
  end


  private

  def create_birthday
    self.birthday = Date.new(self.birthday_year.to_i, self.birthday_month.to_i, self.birthday_day.to_i)
  end

end
