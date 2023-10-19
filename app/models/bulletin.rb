class Bulletin < ApplicationRecord
  belongs_to :user
  has_many :likes,dependent: :destroy
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true
  has_one_attached :image
end
