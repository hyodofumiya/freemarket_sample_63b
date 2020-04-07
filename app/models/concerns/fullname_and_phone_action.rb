module FullnameAndPhoneAction
  extend ActiveSupport::Concern
  included do
    before_validation :correct_phone_number

    validates :family_name, presence: true, format: {with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: I18n.t('errors.messages.not_a_zenkaku')}
    validates :family_name_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/, message: I18n.t('errors.messages.not_a_katakana')}
    validates :first_name, presence: true, format: {with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: I18n.t('errors.messages.not_a_zenkaku')}
    validates :first_name_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/, message: I18n.t('errors.messages.not_a_katakana')}
    validates :phone_number, format: {with: /\A\d*\z/, message: I18n.t('errors.messages.not_a_number')}
  end

  private

  def correct_phone_number
    correct_number("phone_number")
  end

  def correct_number(method)
    self.send(method)&.tr!("０-９", "0-9")
    self.send(method)&.delete!("-")
  end
end

