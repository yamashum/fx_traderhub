# frozen_string_literal: true

class BulletinChatsController < ApplicationController
  def index
    bulletin_id = params[:bulletin_id]
    @chat_messages = BulletinChat.where(bulletin_id: bulletin_id).includes(:user)
    chat_messages_with_user_info = @chat_messages.map do |message|
      {
        content: message.content,
        user_name: message.user.nickname
      }
    end

    render json: chat_messages_with_user_info
  end
end
