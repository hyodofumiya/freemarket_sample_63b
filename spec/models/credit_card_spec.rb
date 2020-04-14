require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  describe "create" do
    context "success" do
      it "user_id,card_id,customer_idがある場合、保存できる" do
        credit_card = build(:credit_card)
        expect(credit_card).to be_valid
      end
    end

    context "fails" do
      it "user_idがない場合、無効" do
        credit_card = build(:credit_card, user_id: nil)
        credit_card.valid?
        expect(credit_card.errors.messages[:user]).to include("を入力してください") 
      end
      it "card_idがない場合、無効" do
        credit_card = build(:credit_card, card_id: nil)
        credit_card.valid?
        expect(credit_card.errors.messages[:card_id]).to include("を入力してください") 
      end

      it "customer_idがない場合、無効" do
        credit_card = build(:credit_card, customer_id: nil)
        credit_card.valid?
        expect(credit_card.errors.messages[:customer_id]).to include("を入力してください")
      end
    end
  end
end
