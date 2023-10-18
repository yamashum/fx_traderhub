class EventsController < ApplicationController

    def index
      @q = Event.ransack(params[:q])
      if params[:q].present? # パラメータ q が送信された場合、つまり検索が行われた場合
        @q = Event.ransack(params[:q])
        @events = @q.result.includes(:user).order(created_at: :desc).page(params[:page]).per(10) 
      else
        @events = Event.all.includes(:user).order(created_at: :desc).page(params[:page]).per(10) 
      end
    end

    def new
      @event = Event.new
    end

    def create
      tag_names = event_params.delete(:tag_list).split(',')
      @event = current_user.events.build(event_params)
    
      if @event.save
        # イベントが保存された後、タグを処理するロジックを追加
        tag_names.each do |tag_name|
          tag = Tag.find_or_create_by(name: tag_name.strip)
          @event.tags << tag
        end
        redirect_to events_path , notice: 'イベントが作成されました。'
      else
        render :new
      end
    end
  

    def show
      @event =  Event.find(params[:id])
      session[:user_name] = current_user.nickname
    end

   

    def destroy
      @event = Event.find(params[:id])
      @event.destroy
      redirect_to events_path, notice: 'イベントが削除されました。'
    end

    private

    def event_params
      params.require(:event).permit(:name, :detail, :start_time, :link, :tag_list)
    end


end
