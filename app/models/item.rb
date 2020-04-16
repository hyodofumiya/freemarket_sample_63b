class Item < ApplicationRecord
    has_one :order
    belongs_to :user
    belongs_to :brand, optional: true
    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :categories
    has_many :images, dependent: :destroy
    accepts_nested_attributes_for :images, allow_destroy: true
    SIZE = {"0"=> "XS", "5"=> "S", "10"=> "M", "15"=> "L", "20"=> "XL"}#DBの値とサイズの割付定数
    CONDITION = {"0"=> "新品", "5"=> "未使用に近い", "10"=> "目立った傷や汚れなし", "15"=> "やや傷や汚れあり", "20"=> "傷や汚れあり", "25"=> "状態悪い"}
    DELIVARY = {"0"=> "出品者負担", "5"=> "購入者負担"}

    before_validation :delete_empty_image

#==========バリデーション==============
    validates :name, presence: true
    validates :discription, presence: true
    validates :condition, presence: true, inclusion: {in: CONDITION.values}
    validates :delivary, presence: true, inclusion: {in: DELIVARY.values}
    validates :size, inclusion: {in: (SIZE.values | [nil])}
    validates :area, presence: true, inclusion: {in: Prefectures.array}
    validates :preparation_day, presence: true
    validates :price, presence: true, length: { minimum: 0 }
    validates :images, presence: true
#====================================
    
#==========DBには数値が入るカラムのゲッターとセッター==================
    def size
        return get_selector(Item::SIZE, super&.to_i)
    end

    def condition
        return get_selector(Item::CONDITION, super&.to_i)
    end

    def delivary
        return get_selector(Item::DELIVARY, super&.to_i)
    end

    def size=(value)
        return set_selector(Item::SIZE, value.to_i){super(value)}
    end

    def condition=(value)
        return set_selector(Item::CONDITION, value.to_i){super(value)}
    end

    def delivary=(value)
        return set_selector(Item::DELIVARY, value.to_i){super(value)}
    end

    #=============都道府県を入れるカラムのゲッターとセッター==========
    def area
        return Prefectures.find(super)
    end

    #=============================================================

#=================================================================

#===================フォーム用のゲッター============================
    def brand_name
        return self.brand&.name
    end
#=================================================================
    private
    def get_selector(selector, value)
        selector.each do |selector_num, text|
            if(selector_num.to_i == value)
                return text
            end
        end
        nil
    end

    def set_selector(selector, value)
        selector.each do |selector_num, text|
            if selector_num.to_i == value
                return yield
            end
        end
        nil
    end

    def delete_empty_image
        temp_images = []
        self.images.each do |image|
            unless image.photo.file.nil?
                temp_images << image
            end
        end
        self.images.replace(temp_images)
    end
end
