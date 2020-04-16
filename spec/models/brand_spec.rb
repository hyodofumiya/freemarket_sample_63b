require 'rails_helper'

RSpec.describe Brand, type: :model do
  describe "#create" do
    context "success" do
        it "is success registration with all value" do
            brand = build(:brand)
            expect(brand).to be_valid
        end
    end

    context "failure by nil" do
      it "is failure registration without name" do
          brand = build(:brand, name: nil)
          brand.valid?
          expect(brand.errors[:name]).to include(I18n.t('errors.messages.blank'))
      end
    end

    context "failure by validation spec" do
      it "is failure registration with non unique name" do
        create(:brand, name: "シャネル")
        brand = build(:brand, name: "シャネル")
        brand.valid?
        expect(brand.errors[:name]).to include(I18n.t('errors.messages.taken'))
    end
    end
  end
end
