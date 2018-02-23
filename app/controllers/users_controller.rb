class UsersController < ApplicationController
  
  before_action :require_user_logged_in, only: [:edit, :update,:show]
  before_action :correct_user,   only: [:edit, :update]
  
  def index
  end

  def show
    @user = User.find(params[:id])
    @items = @user.items.uniq
    @count_want = @user.want_items.count
  end

  def new
     @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.send_activation_email
      #UserMailer.account_activation(@user).deliver_now
      flash[:info] = "登録頂いたアドレスに本登録メールを送信しました。ご確認ください。"
      redirect_to root_url
      
      #Basic 登録
      #log_in @user
      #flash[:success] = 'ユーザを登録しました。'
      #redirect_to @user
     else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "変更内容を登録しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  #def logged_in_user
   # unless logged_in?
    #  store_location
     # flash[:danger] = "ログインしてください"
      #redirect_to login_url
    #end
  #end
end
