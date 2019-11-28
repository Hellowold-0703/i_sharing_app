class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
         
  has_many :places
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :like_places, through: :likes, source: :place
end
