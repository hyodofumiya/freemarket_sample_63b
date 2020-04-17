require 'rails_helper'

RSpec.describe Order, type: :model do

  describe "#create" do
    context "success" do
      it "user_id,item_id,credit_card_idがある場合、有効である" do
        order = build(:order)
        expect(order).to be_valid
      end
    end
    
    context "fails" do
      it "user_idがない場合無効" do
        order = build(:order, user_id: nil)
        order.valid?
        expect(order.errors.messages[:user]).to include("を入力してください")
      end
      it "item_idがない場合無効" do
        order = build(:order, item_id: nil)
        order.valid?
        expect(order.errors.messages[:item]).to include("を入力してください")
      end
      it "credit_card_idがない場合無効" do
        order = build(:order, credit_card_id: nil)
        order.valid?
        expect(order.errors.messages[:credit_card]).to include("を入力してください")
      end
    end
  end
end
