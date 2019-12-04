class Image < ApplicationRecord

  belongs_to :place

  validates :image, presence: true

  mount_uploader :image, ImageUploader
end
