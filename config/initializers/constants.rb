module Constants
  EMAIL_CONFIRMATION_LIMIT = Rails.env.production? ? 1.day : 10.minutes
end
