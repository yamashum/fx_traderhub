# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to root_path, notice: '新規登録が成功しました。'
    else
      render 'new'
    end
  end

  def edit; end

  def show; end

  def update
    if @user.update(user_profile_params)
      redirect_to @user, notice: 'プロフィールが更新されました。'
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    log_out if logged_in?
    redirect_to root_url, notice: 'アカウントが削除されました。'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :nickname, :icon_image,
                                 :self_introduction)
  end

  def user_profile_params
    params.require(:user).permit(:nickname, :icon_image, :self_introduction)
  end
end
