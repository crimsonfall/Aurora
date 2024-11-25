class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post

  # Users that this user is following
  has_many :follows, foreign_key: :follower_id, dependent: :destroy
  has_many :followed_users, through: :follows, source: :followed

  # Users that are following this user
  has_many :reverse_follows, class_name: "Follow", foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :reverse_follows, source: :follower

  has_one_attached :profile_picture
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.admin ||= false
  end

  def admin?
    self.admin
  end
end
