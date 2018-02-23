class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end
  
  def read(result)
    code = result['isbn']
    name = result['title']
    url = result['itemUrl']
    image_url = result['largeImageUrl']

    return {
      code: code,
      name: name,
      url: url,
      image_url: image_url,
    }
  end
  
end