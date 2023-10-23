# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :events, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bulletins,  dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :chat_messages
  has_many :bulletin_chats, dependent: :destroy
  has_one_attached :icon_image

  def liked_bulletins
    # ここでユーザーが「いいね」を付けた掲示板を取得するロジックを実装
    Bulletin.joins(:likes).where(likes: { user_id: id })
  end

  def liked_by?(bulletin)
    liked_bulletins.include?(bulletin)
  end

  def unread_notifications
    notifications.where(read: false)
  end
end
