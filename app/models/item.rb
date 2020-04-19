class Item < ApplicationRecord
    has_one :order
    belongs_to :user
    belongs_to :brand, optional: true
    belongs_to :category
    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :images, dependent: :destroy
    accepts_nested_attributes_for :images, allow_destroy: true
    has_many :orders
    SIZE = {"0"=> "XS", "5"=> "S", "10"=> "M", "15"=> "L", "20"=> "XL"}#DBの値とサイズの割付定数
    CONDITION = {"0"=> "新品", "5"=> "未使用に近い", "10"=> "目立った傷や汚れなし", "15"=> "やや傷や汚れあり", "20"=> "傷や汚れあり", "25"=> "状態悪い"}
    DELIVARY = {"0"=> "出品者負担", "5"=> "購入者負担"}


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
    scope :category_items, ->(num) { where(category_id: Category.find(num).subtree_ids, status: true).order(created_at: :DESC).includes(:images, :comments, :favorites) }
    
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

    def delete_images(image_params)
        self.images.each do |image|
            delete_flg = true
            unless(image.persisted?)#画像が新規投稿ならこの周はチェックしない
                next
            end
            image_params.values.each do |image_hash|
                if image_hash[:id]&.to_i == image.id
                    delete_flg = false
                    break
                end
            end
            self.images.delete(image) if delete_flg
        end
    end

    def replace_image(image_params)
        new_images = []
        image_params.each do |key, hash|
            if(hash[:photo])
                new_images << self.images.create(hash)
            elsif(hash[:id])
                new_images << Image.find(hash[:id].to_i)
            end
        end
        self.images.replace(new_images)
    end

    def delete_empty_image
        new_images = self.images
        new_images.each do |image|
            if image.photo&.file.nil?
                new_images.delete(image)
            end
        end
        self.images.replace(new_images)
    end

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
end
