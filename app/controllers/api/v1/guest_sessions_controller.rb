class Api::V1::GuestSessionsController < ApplicationController

  def create
    user = User.find_or_create_by(email: "guest@example.com") do |u|
      u.name = "ゲストユーザー"
      u.password = "password"
      u.prefecture = "東京都"
      u.zipcode = "104-0061"
      u.street = "東京都中央区銀座6-18-2"
      u.building = "野村不動産銀座ビル 11階"
      u.profile_text = "ゲストユーザーです。"
      u.confirmation_status = 0
    end

    render json: { auth: { email: user.email, password: "password" }}
  end
end
