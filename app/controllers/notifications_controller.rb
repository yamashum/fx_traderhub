# frozen_string_literal: true

class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  def mark_as_read
    notification = Notification.find(params[:id])
    notification.update(read: true)
    redirect_to notifications_path, notice: '通知を既読にしました。'
  end
end
