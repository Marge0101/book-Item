class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  #def account_activation
    #@greeting = "Hi"

    #mail to: "to@example.org"
  #end

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "本登録をお願い致します。from Book Item"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  #def password_reset
    #@greeting = "Hi"

    #mail to: "to@example.org"
  #åend
  
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワードの再設定をお願い致します。from Book Item"
  end
  
  
  
end
