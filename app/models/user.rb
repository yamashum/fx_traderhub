class User < ApplicationRecord
    has_secure_password
    validates :nickname, presence: true
    validates :email, presence: true, uniqueness: true
    has_one_attached :icon_image
    has_many :events, dependent: :destroy
    has_many :bulletins,  dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :notifications,dependent: :destroy

    def liked_bulletins
        # ここでユーザーが「いいね」を付けた掲示板を取得するロジックを実装
        Bulletin.joins(:likes).where(likes: { user_id: self.id })
    end

    def liked_by?(bulletin)
        liked_bulletins.include?(bulletin)
    end

    def unread_notifications
        notifications.where(read: false)
      end
end