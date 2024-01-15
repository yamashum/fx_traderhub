# frozen_string_literal: true
require 'line/bot'
class EventsController < ApplicationController
  def index
    @q = Event.ransack(params[:q])
    @events = @q.result.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @event = Event.new
  end

  def create
    tag_names = event_params.delete(:tag_list).split(',')
    @event = current_user.events.build(event_params)

    if @event.save
      create_tags(tag_names)
      create_notification
      send_line_notification(@event)
      redirect_to events_path, notice: 'イベントが作成されました。'
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
    session[:user_name] = current_user.nickname
  end

  def calendar
    @events = Event.all
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, notice: 'イベントが削除されました。'
  end

  private

  def send_line_notification(event)
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
    message = {
      type: 'text',
      text: "新しいイベントが作成されました\n
      イベント名: #{event.name}\n
      開催日時: #{event.start_time.strftime('%Y年%m月%d日 %H:%M')}\n
      リンク: #{event.link}\n"
    }
    

    # ここで友達全員に通知を送る
    client.broadcast(message)
end


  def event_params
    params.require(:event).permit(:name, :detail, :start_time, :link, :tag_list)
  end

  def create_tags(tag_names)
    tag_names.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name.strip)
      @event.tags << tag
    end
  end

  def create_notification
    Notification.create(content: "#{current_user.nickname}が新しいイベントが作成されました", user: current_user)
  end
end
