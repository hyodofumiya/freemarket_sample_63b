module FullnameAndPhoneAction
  extend ActiveSupport::Concern
  included do
    before_validation :correct_phone_number

    validates :family_name, presence: true
    validates :family_name_kana, presence: true
    validates :first_name, presence: true
    validates :first_name_kana, presence: true
    validates :phone_number, format: {with: /\A\d+\z/, message: I18n.t('errors.messages.not_a_number')}
  end

  def correct_phone_number
    self.phone_number.tr!("０-９", "0-9")
    self.phone_number.delete!("-")
  end
end