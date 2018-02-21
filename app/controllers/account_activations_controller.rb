class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      #user.update_attribute(:activated,    true)
      #user.update_attribute(:activated_at, Time.zone.now)
      log_in user
      flash[:success] = "本登録が完了いたしました!"
      redirect_to user
    else
      flash[:danger] = "登録できておりません。"
      redirect_to root_url
    end
  end
end