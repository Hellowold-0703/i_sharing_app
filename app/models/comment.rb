class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :place
  has_many :notifications
end
