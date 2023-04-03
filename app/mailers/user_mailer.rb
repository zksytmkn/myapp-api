class UserMailer < ApplicationMailer
  default from: 'edible010126@gmail.com'

  def send_email_confirmation(user)
    @user = user
    mail(to: @user.email, subject: '【Edible】メールアドレス確認のお願い')
  end

  def send_email_reset_confirmation(user, email, token)
    @user = user
    @email = email
    @token = token
    mail(to: @email, subject: '【Edible】メールアドレス変更のご連絡')
  end

  def send_password_reset_confirmation(user)
    @user = user
    mail(to: @user.email, subject: '【Edible】パスワード変更のご連絡')
  end

  def send_password_reset(user, token)
    @user = user
    @token = token
    mail(to: @user.email, subject: '【Edible】パスワード再設定のご案内')
  end

  def send_contact_email(name, email, contents)
    @name = name
    @contents = contents
    mail(to: email, subject: '【Edible】お問い合わせありがとうございます')
  end
end
