require 'rails_helper'

RSpec.describe User, type: :model do

    describe "#create" do
        context "success" do
            it "is success registration with all value" do
                user = build(:user)
                expect(user).to be_valid
            end

            it "is success registration without phone_number" do
                user = build(:user)
                expect(user).to be_valid
            end

            it "is success registration with phone_number included hyphen" do
                user = build(:user, phone_number: "0120-828-828")
                expect(user).to be_valid
            end

            it "is success registration with phone_number included double byte chara" do
                user = build(:user, phone_number: "０１２０-８２８-８２８")
                expect(user).to be_valid
            end
            
            it "is success registration with birthday date" do
                user = build(:user, birthday: nil, birthday_year: 2000, birthday_month: 1, birthday_day: 1)
                expect(user).to be_valid
            end
        end

        context "failure by nil" do
            it "is failure registration without nickname" do
                user = build(:user, nickname: nil)
                user.valid?
                expect(user.errors[:nickname]).to include(I18n.t('errors.messages.blank'))
            end

            it "is failure registration without email" do
                user = build(:user, email: nil)
                user.valid?
                expect(user.errors[:email]).to include(I18n.t('errors.messages.blank'))
            end

            it "is failure registration without family_name" do
                user = build(:user, family_name: nil)
                user.valid?
                expect(user.errors[:family_name]).to include(I18n.t('errors.messages.blank'))
            end

            it "is failure registration without first_name" do
                user = build(:user, first_name: nil)
                user.valid?
                expect(user.errors[:first_name]).to include(I18n.t('errors.messages.blank'))
            end

            it "is failure registration without family_name_kana" do
                user = build(:user, family_name_kana: nil)
                user.valid?
                expect(user.errors[:family_name_kana]).to include(I18n.t('errors.messages.blank'))
            end

            it "is failure registration without first_name_kana" do
                user = build(:user, first_name_kana: nil)
                user.valid?
                expect(user.errors[:first_name_kana]).to include(I18n.t('errors.messages.blank'))
            end
        end

        context "failure by validation spec" do
            it "is failure registration with phone_number included except number" do
                user = build(:user, phone_number: "tokyo2020")
                user.valid?
                expect(user.errors[:phone_number]).to include(I18n.t('errors.messages.not_a_number'))
            end

            it "is failure registration with wrong email address" do
                user = build(:user, email: "email")
                user.valid?
                expect(user.errors[:email]).to include(I18n.t('errors.messages.invalid'))
            end

            it "is failure registration with same email address" do
                create(:user, email: "a@a")
                user = build(:user, email: "a@a")
                user.valid?
                expect(user.errors[:email]).to include(I18n.t('errors.messages.taken'))
            end

            it "is failure registration with six charas password" do
                user = build(:user, password: "aaa", password_confirmation: "aaa")
                user.valid?
                expect(user.errors[:password]).to include(I18n.t('errors.messages.too_short', count: 7))
            end
        end
    end
end
