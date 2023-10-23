# frozen_string_literal: true

class Bulletin < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true
  has_one_attached :image
  has_many :bulletin_chats, dependent: :destroy
end
