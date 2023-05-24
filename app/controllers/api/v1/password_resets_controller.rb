class Api::V1::PasswordResetsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    @token = params[:token]
    user = User.find_by(reset_password_token: @token)
  
    if user && !user.reset_password_expired?
      if PasswordValidator.is_password_valid?(params[:password])
        if user.update(password: params[:password], reset_password_token: nil, reset_password_expires_at: nil)
          render json: { message: 'パスワードが正常に更新されました。' }, status: :ok
        else
          render json: { message: user.errors.full_messages.to_sentence }, status: :unprocessable_entity
        end
      else
        render json: { message: '無効なパスワードです。もう一度お試しください。' }, status: :unprocessable_entity
      end
    else
      render json: { message: 'リンクが無効か期限切れです。もう一度パスワードリセット手続きを行ってください。' }, status: :unprocessable_entity
    end
  end

  def reset_password_confirmation
    @token = params[:token]
    user = User.find_by(reset_password_token: @token)

    if user && !user.reset_password_expired?
      render :reset_password_confirmation
    else
      regenerate_password_reset_link(user)
    end
  end

  private

  def regenerate_password_reset_link(user)
    token = SecureRandom.urlsafe_base64
    user.update!(reset_password_token: token, reset_password_expires_at: Time.zone.now + 1.hour)
    UserMailer.send_password_reset(user, token).deliver_later
    redirect_to new_password_reset_path, notice: '新しいパスワード再設定リンクをメールで送信しました。'
  end
end
