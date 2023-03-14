class UserMailer < ApplicationMailer
  default from: 'edible010126@gmail.com'

  def send_email_confirmation(user)
    @user = user
    mail(to: @user.email, subject: '【Edible】メールアドレス確認のお願い')
  end
end
