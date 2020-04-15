class Item < ApplicationRecord
    has_one :order
    belongs_to :user
    belongs_to :brand, optional: true
    belongs_to :category
    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :images, dependent: :destroy
    has_many :orders
    SIZE = {"0"=> "XS", "5"=> "S", "10"=> "M", "15"=> "L", "20"=> "XL"}#DBの値とサイズの割付定数
    CONDITION = {"0"=> "新品", "5"=> "未使用に近い", "10"=> "目立った傷や汚れなし", "15"=> "やや傷や汚れあり", "20"=> "傷や汚れあり", "25"=> "状態悪い"}
    DELIVARY = {"0"=> "出品者負担", "5"=> "購入者負担"}

    scope :category_items, ->(num) { where(category_id: Category.find(num).subtree_ids, status: true).order(created_at: :DESC).includes(:images, :comments, :favorites) }
    
#==========DBには数値が入るカラムのゲッターとセッター==================
    def size
        return get_selector(Item::SIZE, super)
    end

    def condition
        return get_selector(Item::CONDITION, super)
    end

    def delivary
        return get_selector(Item::DELIVARY, super)
    end

    def size=(value)
        return set_selector(Item::SIZE, value){super(value)}
    end

    def condition=(value)
        return set_selector(Item::CONDITION, value){super(value)}
    end

    def delivary=(value)
        return set_selector(Item::DELIVARY, value){super(value)}
    end

    #=============都道府県を入れるカラムのゲッターとセッター==========
    def area
        return Prefectures.find(super)
    end

    def area=(prefecture)
        super(Prefectures.find_by(default: prefecture))
    end

    #=============================================================

#=================================================================



    private
    def get_selector(selector, value)
        return nil unless value
        selector.each do |selector_num, text|
            if(selector_num.to_i == value)
                return text
            end
        end
        raise ArgumentError.new, "存在しないセレクターです。"
    end

    def set_selector(selector, value)
        selector.each do |selector_num, text|
            if selector_num.to_i == value
                return yield
            end
        end
        raise ArgumentError.new, "存在しないセレクターです。"
    end
end
