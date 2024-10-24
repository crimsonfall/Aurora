class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true
  validates :description, length: { maximum: 140, message: "must be 140 characters or less" }, allow_blank: true
  validates :image, presence: { message: "must be uploaded" }
end
