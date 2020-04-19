class Image < ApplicationRecord
  mount_uploader :photo, ImageUploader
  belongs_to :item
  validates :photo, presence: true
end
