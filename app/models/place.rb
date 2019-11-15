class Place < ApplicationRecord

  mount_uploaders :images, ImageUploader
  serialize :images, JSON

  geocoded_by :address
  before_validation :geocode, if: :address_changed?

  validates :title, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :images, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end