class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :likers, through: :likes, source: :user
  has_one_attached :image

  validates :title, presence: true
  validates :description, length: { maximum: 140, message: "must be 140 characters or less" }, allow_blank: true
  validates :image, presence: { message: "must be uploaded" }

  LICENSES = ["Copyright", "Free Art License", "CC BY", "CC BY-SA", "CC BY-NC", "CC BY-NC-SA", "CC BY-ND", "CC BY NC-ND", "CC0"]
  validates :license, inclusion: { in: LICENSES }

  def self.search(keyword)
    return Post.none if keyword.blank?

    where("LOWER(title) LIKE ?", "%#{keyword.downcase}%")
  end
end
