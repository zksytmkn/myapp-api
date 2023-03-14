class Api::V1::UsersController < ActionController::Base

  def index
    users = User.all
    render json: users, methods: [:image_url]
  end

  def create
    @user = User.new(user_parmas)
    @user.save!
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
  end

  def destroy
  end

  def confirm_email
    if @user = User.find_by(confirmation_token: params[:token])
      unless @user.expired?
        @user.activate
        if @user&.confirmed?
          redirect_to "http://localhost:8080/login"
          flash[:success] = 'アカウントが有効化されました'
        end
      end
    else
      redirect_to "http://localhost:8080"
      flash[:error] = "この有効化リンクは無効です"
    end
  end

  def user_parmas
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
