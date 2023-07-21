class Api::V1::GuestSessionsController < ApplicationController
  include UserSessionizeService

  def generate_password
    length = 10
    symbols = '!@#$%^&*()-=_+[]{}|;:,.<>?/`~'
    charset = Array('A'..'Z') + Array('a'..'z') + Array('0'..'9') + symbols.split('')
    password = Array.new(length - 4) { charset.sample }
    password += [Array('A'..'Z').sample, Array('a'..'z').sample, Array('0'..'9').sample, symbols.split('').sample]
    password.shuffle.join
  end

  def create
    begin
      user = User.create!(
        email: SecureRandom.uuid + "@example.com",
        name: "ゲストユーザー",
        password: generate_password,
        prefecture: "東京都",
        zipcode: "104-0061",
        street: "東京都中央区銀座6-18-2",
        building: "野村不動産銀座ビル 11階",
        profile_text: "ゲストユーザーです。",
        confirmation_status: "confirmed",
        is_guest: true
      )
  
      render json: { auth: { email: user.email, password: user.password }}
    rescue => e  # Catch all exceptions
      Rails.logger.error "Failed to create guest user: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      render json: { error: 'ゲストログインできませんでした' }, status: :internal_server_error
    end
  end

  # ログアウト
  def destroy
    if session_user.forget
      delete_session 
      session_user.destroy if session_user.is_guest
    end
    cookies[session_key].nil? ?
      head(:ok) : response_500("Could not delete session")
  end  
end
