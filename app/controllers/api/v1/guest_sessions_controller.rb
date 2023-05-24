class Api::V1::GuestSessionsController < ApplicationController

  def create
    begin
      user = User.create!(
        email: SecureRandom.uuid + "@example.com",
        name: "ゲストユーザー",
        password: SecureRandom.hex(10),
        prefecture: "東京都",
        zipcode: "104-0061",
        street: "東京都中央区銀座6-18-2",
        building: "野村不動産銀座ビル 11階",
        profile_text: "ゲストユーザーです。",
        confirmation_status: 0,
        is_guest: true
      )

      render json: { auth: { email: user.email, password: user.password }}
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "Failed to create guest user: #{e.message}"
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
