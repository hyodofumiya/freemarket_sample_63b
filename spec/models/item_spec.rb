require 'rails_helper'

RSpec.describe Item, type: :model do
    describe "#create" do
        context "success" do
            it "is success registration with all value" do
                item = build(:item)
                expect(item).to be_valid
            end

            it "is success registration without brand" do
                item = build(:item, brand_id: nil)
                expect(item).to be_valid
            end

            it "is success registration without size" do
                item = build(:item, size: nil)
                expect(item).to be_valid
            end
        end


        context "failure by nil" do
            it "is failure registration without name" do
                item = build(:item, name: nil)
                item.valid?
                expect(item.errors[:name]).to include(I18n.t('errors.messages.blank'))
            end

            it "is failure registration without discription" do
                item = build(:item, discription: nil)
                item.valid?
                expect(item.errors[:discription]).to include(I18n.t('errors.messages.blank'))
            end

            it "is failure registration without condition" do
                item = build(:item, condition: nil)
                item.valid?
                expect(item.errors[:condition]).to include(I18n.t('errors.messages.blank'))
            end

            it "is failure registration without delivary" do
                item = build(:item, delivary: nil)
                item.valid?
                expect(item.errors[:delivary]).to include(I18n.t('errors.messages.blank'))
            end

            it "is failure registration without area" do
                item = build(:item, area: nil)
                item.valid?
                expect(item.errors[:area]).to include(I18n.t('errors.messages.blank'))
            end

            it "is failure registration without preparation_day" do
                item = build(:item, preparation_day: nil)
                item.valid?
                expect(item.errors[:preparation_day]).to include(I18n.t('errors.messages.blank'))
            end

            it "is failure registration without price" do
                item = build(:item, price: nil)
                item.valid?
                expect(item.errors[:price]).to include(I18n.t('errors.messages.blank'))
            end

            it "is failure registration without image" do
                item = build(:noneImageItem)
                item.valid?
                expect(item.errors[:images]).to include(I18n.t('errors.messages.blank'))
            end

            it "is failure registration without category" do
                skip #カテゴリのfactory_bot作成後skipを外してください。(items.rbのコメントアウトも外してください。)
                item = build(:item, category_id: nil)
                item.valid?
                expect(item.errors[:category_id]).to include(I18n.t('errors.messages.blank'))
            end
        end

        context "failure by validation spec" do
            it "is failure registration with condition included invalid number" do
                item = build(:item, condition: "-1")
                item.valid?
                expect(item.errors[:condition]).to include(I18n.t('errors.messages.inclusion'))
            end

            it "is failure registration with delivary included invalid number" do
                item = build(:item, delivary: "-1")
                item.valid?
                expect(item.errors[:delivary]).to include(I18n.t('errors.messages.inclusion'))
            end

            it "is failure registration with area included invalid number" do
                item = build(:item, area: "-1")
                item.valid?
                expect(item.errors[:area]).to include(I18n.t('errors.messages.blank'))
            end
        end
    end
    
end
