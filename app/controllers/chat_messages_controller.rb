# frozen_string_literal: true

class ChatMessagesController < ApplicationController
  def index
    event_id = params[:event_id]
    @chat_messages = ChatMessage.where(event_id: event_id).includes(:user)
    chat_messages_with_user_info = @chat_messages.map do |message|
      {
        content: message.content,
        user_name: message.user.nickname
      }
    end

    render json: chat_messages_with_user_info
  end
end
