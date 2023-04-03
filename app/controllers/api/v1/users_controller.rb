require_relative '../../../../lib/validator/password_validator'

class Api::V1::UsersController < ActionController::Base
  include UserAuthenticateService

  before_action :confirm_password, only: [:send_email_reset_confirmation]

  def index
    users = User.all
    render json: users, methods: [:image_url]
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserEmailService.send_email_confirmation(@user)
    end
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    user = User.find(params[:id])
    user.update!(user_params)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy!
  end

  def send_email_reset_confirmation
    set_email_reset_confirmation
    token = SecureRandom.urlsafe_base64
    current_user.update!(confirmation_token: token)
    new_email = params[:email]
    UserMailer.send_email_reset_confirmation(current_user, new_email, token).deliver_later
  end

  def set_email_reset_confirmation
    current_user.update!(expiration_date: Time.zone.now + Constants::EMAIL_CONFIRMATION_LIMIT)
  end

  def update_password
    if current_user.update(password: params[:password])
      UserMailer.send_password_reset_confirmation(current_user).deliver_later
      render json: { message: "パスワードが正常に更新されました" }, status: :ok
    else
      render json: { message: current_user.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def confirm_email
    user = User.find_by(confirmation_token: params[:token])
    if valid_token?(user)
      user.activate
      email = params[:email]
      user.update!(email: email) if email.present?
      if user&.confirmed?
        render 'users/activate_account_success'
      end
    else
      render 'users/activate_account_error_invalid'
    end
  end

  def confirm_email_reset
    user = User.find_by(confirmation_token: params[:token])
    email = params[:email]
  
    if valid_token?(user)
      if User.where(email: email).exists?
        render 'users/change_email_error_duplicate'
      else
        user.update!(email: email, confirmation_token: nil)
        render 'users/change_email_success'
      end
    else
      render 'users/change_email_error_invalid'
    end
  end

  def confirm_password
    unless current_user.present? && current_user.authenticate(params[:current_password])
      raise UserAuth.not_found_exception_class
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
      render json: { message: "メールアドレスが見つかりません" }, status: :not_found
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
          render json: { message: user.errors.full_messages.join(", ") }, status: :unprocessable_entity
        end
      end
    else
      render json: { error: '無効なトークンです' }, status: :unprocessable_entity
    end
  end
  
  private
  
  def user_params
    params.permit(:name, :email, :prefecture, :zipcode, :street, :building, :text, :password)
  end
end