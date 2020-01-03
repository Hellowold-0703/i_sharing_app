class Image < ApplicationRecord

  belongs_to :place

  validates :place, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader
  before_destroy :remove_destroy

  private

  def remove_destroy
    image.remove!
    image.thumb.remove!
  rescue => e
    logger.error(e.message)
  end
end
