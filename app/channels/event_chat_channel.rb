# frozen_string_literal: true

class EventChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "event_chat_#{params[:event_id]}"
    @user = current_user
  end

  def unsubscribed; end

  def receive(data)
    ActionCable.server.broadcast("event_chat_#{params[:event_id]}", {
                                   content: data['content'],
                                   user_name: @user.nickname,

                                   user_id: @user.id,
                                   action: 'receive'
                                 })
  end

  def speak(data)
    content = data['content']
    message = @user.chat_messages.create(content: content, event_id: params[:event_id])

    ActionCable.server.broadcast("event_chat_#{params[:event_id]}", {
                                   content: message.content,
                                   user_name: @user.nickname,

                                   user_id: @user.id,
                                   action: 'speak'
                                 })
  end
end
