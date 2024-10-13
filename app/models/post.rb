class Post < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: { message: "must be uploaded" }
end
