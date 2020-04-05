require 'rails_helper'

RSpec.describe ShoppingAddress, type: :model do
  describe "#create" do
    context "success" do
        it "is success registration with all value" do
            address = build(:shopping_address)
            expect(address).to be_valid
        end

        it "is success registration without phone_number" do
            address = build(:shopping_address, phone_number: nil)
            expect(address).to be_valid
        end

        it "is success registration without building_name" do
            address = build(:shopping_address, building_name: nil)
            expect(address).to be_valid
        end

        it "is success registration with post_cord included double chara" do
            address = build(:shopping_address, post_cord: "４３０９２７５４８７")
            expect(address).to be_valid
        end

        it "is success registration with post_cord included hyphen" do
            address = build(:shopping_address, post_cord: "0120-828-828")
            expect(address).to be_valid
        end
    end

    context "failure by nil" do
      it "is failure registration without family_name" do
          address = build(:shopping_address, family_name: nil)
          address.valid?
          expect(address.errors[:family_name]).to include(I18n.t('errors.messages.blank'))
      end
      
      it "is failure registration without family_name_kana" do
        address = build(:shopping_address, family_name_kana: nil)
        address.valid?
        expect(address.errors[:family_name_kana]).to include(I18n.t('errors.messages.blank'))
      end
        
      it "is failure registration without first_name" do
        address = build(:shopping_address, first_name: nil)
        address.valid?
        expect(address.errors[:first_name]).to include(I18n.t('errors.messages.blank'))
      end
          
      it "is failure registration without first_name_kana" do
        address = build(:shopping_address, first_name_kana: nil)
        address.valid?
        expect(address.errors[:first_name_kana]).to include(I18n.t('errors.messages.blank'))
      end
          
      it "is failure registration without post_cord" do
        address = build(:shopping_address, post_cord: nil)
        address.valid?
        expect(address.errors[:post_cord]).to include(I18n.t('errors.messages.blank'))
      end
          
      it "is failure registration without prefecture" do
        address = build(:shopping_address, prefecture: nil)
        address.valid?
        expect(address.errors[:prefecture]).to include(I18n.t('errors.messages.blank'))
      end
          
      it "is failure registration without cities" do
        address = build(:shopping_address, cities: nil)
        address.valid?
        expect(address.errors[:cities]).to include(I18n.t('errors.messages.blank'))
      end
          
      it "is failure registration without address" do
        address = build(:shopping_address, address: nil)
        address.valid?
        expect(address.errors[:address]).to include(I18n.t('errors.messages.blank'))
      end
    end
  end
end
