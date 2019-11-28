class Like < ApplicationRecord
  belongs_to :user
  belongs_to :place, counter_cache: :likes_count

  validates :user_id, presence: true
  validates :place_id, presence: true
end
