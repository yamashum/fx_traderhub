# frozen_string_literal: true

class BulletinChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "bulletin_chat_#{params[:bulletin_id]}"
    @user = current_user
  end

  def unsubscribed; end

  def receive(data)
    ActionCable.server.broadcast("bulletin_chat_#{params[:bulletin_id]}", {
                                   content: data['content'],
                                   user_name: @user.nickname,

                                   user_id: @user.id,
                                   action: 'receive'
                                 })
  end

  def speak(data)
    content = data['content']
    message = @user.bulletin_chats.create(content: content, bulletin_id: params[:bulletin_id])

    ActionCable.server.broadcast("bulletin_chat_#{params[:bulletin_id]}", {
                                   content: message.content,
                                   user_name: @user.nickname,

                                   user_id: @user.id,
                                   action: 'speak'
                                 })
  end
end
