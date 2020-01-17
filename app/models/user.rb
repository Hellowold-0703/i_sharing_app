class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  
  validates :name, presence: true
  has_many :places ,dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_places, through: :likes, source: :place
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  def self.from_omniauth(auth)
    user = User.find_by(uid: auth.uid, provider: auth.provider)
    if user
      return user
    else
      new_user = User.create(
        email: auth.info.email,
        name: auth.info.name,
        uid: auth.uid,
        provider: auth.provider,
        password: Faker::Internet.password(min_length: 8, max_length: 128)
      )
      return new_user
    end
  end
end
