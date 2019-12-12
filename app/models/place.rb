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
  has_many :notifications, dependent: :destroy

  def self.search(search)
    if search
      Place.where(['address LIKE ?', "%#{search}%"])
    else
      Place.all
    end
  end

  def create_notification_like(current_user)

    temp = Notification.where(["visitor_id = ? and visited_id = ? and place_id = ? and action = ?", current_user.id, user_id, id, 'like'])

    if temp.blank?
      notification = current_user.active_notifications.new(
        place_id: id,
        visited_id: user_id,
        action: 'like'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(place_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, comment_id, temp_id['user_id'])
    end

    save_notification_comment(current_user, comment_id, user_id) if temp_ids.blank?
  end
  
  def save_notification_comment(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      place_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
