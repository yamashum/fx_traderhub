# frozen_string_literal: true

class UserSessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])

      log_in user
      redirect_to root_path, notice: 'ログインに成功しました。'
    else

      flash.now[:alert] = 'メールアドレスまたはパスワードが正しくありません。'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path, notice: 'ログアウトしました。'
  end
end
