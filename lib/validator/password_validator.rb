module PasswordValidator
  def self.is_password_valid?(password)
    minLength = 8
    strongRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])(?=.{8,})/
    strongRegex.match?(password) && password.length >= minLength
  end
end
