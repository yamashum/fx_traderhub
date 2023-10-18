class UserSessionsController < ApplicationController

    def new
        
    end
  
    def create
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        # ログイン成功
        log_in user
        redirect_to root_path, notice: 'ログインに成功しました。'
      else
        # ログイン失敗
        flash.now[:alert] = 'メールアドレスまたはパスワードが正しくありません。'
        render 'new'
      end
    end
  
    def destroy
      log_out
      redirect_to root_path, notice: 'ログアウトしました。'
    end


end
