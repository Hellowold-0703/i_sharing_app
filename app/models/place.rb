class Place < ApplicationRecord

  geocoded_by :address
  before_validation :geocode, if: :address_changed?

  validates :title, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :images, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy, inverse_of: :place
  accepts_nested_attributes_for :images
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
end
