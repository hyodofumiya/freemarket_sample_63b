class Brand < ApplicationRecord
    has_many :items
    validates :name, uniqueness: true
end
