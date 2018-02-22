class SessionsController < ApplicationController
  def new
  end
  
  def create
   user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
      log_in user
      redirect_back_or user
      #flash[:success] = 'ログインに成功しました。'
    else
      message  = "アカウントが有効ではありません。 "
      message += "メールをご確認の上、本登録をお願い致します。"
      flash[:warning] = message
      redirect_to root_url
      end
    else
      flash.now[:danger] = 'メールアドレス、又はパスワードが異なります。'
      render 'new'
    end
  end
  
  def destroy
    log_out
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
