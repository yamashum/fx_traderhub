# frozen_string_literal: true

class BulletinsController < ApplicationController
  before_action :set_bulletin, only: %i[show edit update destroy]

  def index
    @selected_attribute = params[:attribute_id]
    @attributes = %w[テクニカル分析 ファンダメンタル分析 その他]
    @bulletins = if @selected_attribute.present? && @selected_attribute != 'すべて'
                   Bulletin.where(new_attributes: @selected_attribute)
                 else
                   Bulletin.all
                 end
  end

  def show; end

  def new
    @bulletin = Bulletin.new
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      redirect_to @bulletin, notice: '掲示が作成されました。'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: '掲示が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @bulletin.destroy
    redirect_to bulletins_url, notice: '掲示が削除されました。'
  end

  def like
    @bulletin = Bulletin.find(params[:id])

    if current_user.liked_bulletins.include?(@bulletin)
      remove_like
    else
      create_like
    end

    render_likes_count
  end

  private

  def remove_like
    @bulletin.likes.find_by(user_id: current_user.id).destroy
  end

  def create_like
    current_user.likes.create(bulletin: @bulletin)
  end

  def render_likes_count
    new_like_count = @bulletin.likes.count
    respond_to do |format|
      format.json { render json: { likes_count: new_like_count } }
    end
  end

  def unlike
    @bulletin = Bulletin.find(params[:id])

    like = current_user.likes.find_by(bulletin: @bulletin)

    like&.destroy

    new_like_count = @bulletin.likes.count

    respond_to do |format|
      format.json { render json: { likes_count: new_like_count } }
    end
  end

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :content, :new_attributes, :image)
  end
end
