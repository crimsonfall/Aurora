class Post < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true
  validates :description, length: { maximum: 140, message: "must be 140 characters or less" }, allow_blank: true
  validates :image, presence: { message: "must be uploaded" }
end
