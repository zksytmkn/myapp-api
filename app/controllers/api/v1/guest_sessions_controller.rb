class Api::V1::GuestSessionsController < ApplicationController

  def create
    user = User.find_or_initialize_by(email: "guest@example.com")

    if  user.new_record?
        user.name = "ゲストユーザー"
        user.email = "guest@example.com"
        user.password = "password"
        user.prefecture = "東京都"
        user.zipcode = "104-0061"
        user.street = "東京都中央区銀座6-18-2"
        user.building = "野村不動産銀座ビル 11階"
        user.text = "ゲストユーザーです。"
        user.activated = true
        user.save!
    end

    render json: { auth: { email: user.email, password: "password" }}
  end
end
