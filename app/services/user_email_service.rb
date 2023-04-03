class UserEmailService
  def self.send_email_confirmation(user)
    UserMailer.send_email_confirmation(user).deliver_later
  end
end
