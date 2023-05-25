require_relative '../../../../lib/validator/password_validator'

class Api::V1::UsersController < ApplicationController

  def index
    render json: User.all.map { |user| user.to_json(index: true) }
  end

  def show
    render json: User.find(params[:id]).to_json(show: true)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.send_email_confirmation(@user).deliver_later
      render json: { message: 'メールアドレスに確認メールを送信しました' }, status: :created
    else
      render json: { error: @user.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])

    unless user == current_user
      render json: { error: 'この操作は許可されておりません' }, status: :unauthorized
      return
    end

    if user.update(user_params)
      render json: { message: 'ユーザー情報を編集しました' }, status: :ok
    else
      render json: { error: user.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user
      UserMailer.send_account_deletion_confirmation(current_user).deliver_later
      begin
        current_user.destroy!
      rescue ActiveRecord::RecordNotDestroyed => e
        render json: { error: 'アカウントを削除できませんでした' }, status: :unprocessable_entity
        return
      end
      render json: { message: 'アカウントを削除しました' }, status: :ok
    else
      render json: { error: 'アカウントが見つかりません' }, status: :not_found
    end
  end

  def send_email_reset_confirmation
    unless params[:current_password].present? && params[:email].present?
      render json: { error: '必要な情報が不足しています' }, status: :unprocessable_entity
      return
    end
  
    unless current_user.present? && current_user.authenticate(params[:current_password])
      render json: { error: '現在のパスワードが間違っています' }, status: :unprocessable_entity
      return
    end
    
    current_user.email = params[:email]
    if current_user.valid?
      set_email_reset_confirmation
      token = SecureRandom.urlsafe_base64
      begin
        current_user.update!(confirmation_token: token)
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: '確認トークンの更新に失敗しました' }, status: :unprocessable_entity
        return
      end
      UserMailer.send_email_reset_confirmation(current_user, params[:email], token).deliver_later
      render json: { message: 'メールアドレスに確認メールを送信しました' }, status: :ok
    else
      render json: { error: current_user.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def set_email_reset_confirmation
    current_user.update!(expiration_date: Time.zone.now + Constants::EMAIL_CONFIRMATION_LIMIT)
  end

  def update_password
    current_user.password = params[:password]
    if current_user.valid?
      current_user.save!
      UserMailer.send_password_reset_confirmation(current_user).deliver_later
      render json: { message: "パスワードを変更しました" }, status: :ok
    else
      render json: { error: current_user.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.record.errors.full_messages.join(", ") }, status: :unprocessable_entity
  end

  def confirm_email
    user = User.find_by(confirmation_token: params[:token])
    if valid_token?(user)
      user.activate
      user.update!(email: params[:email]) if params[:email].present?
      render user.confirmed? ? 'users/activate_account_success' : 'users/activate_account_error_invalid'
    else
      render 'users/activate_account_error_invalid'
    end
  end

  def confirm_email_reset
    user = User.find_by(confirmation_token: params[:token])
    email = params[:email]

    if valid_token?(user)
      user.update!(email: email, confirmation_token: nil)
      render 'users/change_email_success'
    else
      render 'users/change_email_error_invalid'
    end
  end

  def valid_token?(user)
    user.present? && !user.expired?
  end

  def send_password_reset_email
    user = User.find_by(email: params[:email])
    if user
      token = SecureRandom.urlsafe_base64
      user.update!(reset_password_token: token, reset_password_expires_at: Time.zone.now + 1.hour)
      UserMailer.send_password_reset(user, token).deliver_later
      render json: { message: "パスワード再設定用のメールを送信しました" }, status: :ok
    else
      render json: { error: "メールアドレスが見つかりません" }, status: :not_found
    end
  end

  def reset_password
    user = User.find_by(reset_password_token: params[:token])
    if user.present?
      if user.reset_password_expired?
        render json: { error: 'リンクが無効か、期限切れです' }, status: :unprocessable_entity
      else
        if user.update(password: params[:password], reset_password_token: nil, reset_password_expires_at: nil)
          render json: { message: "パスワードが正常に更新されました" }, status: :ok
        else
          render json: { error: user.errors.full_messages.join(", ") }, status: :unprocessable_entity
        end
      end
    else
      render json: { error: '無効なトークンです' }, status: :unprocessable_entity
    end
  end

  private
  
  def user_params
    params.permit(:name, :email, :prefecture, :zipcode, :street, :building, :profile_text, :password, :image)
  end
end