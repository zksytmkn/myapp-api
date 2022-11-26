class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user

  def index
    # users = User.all
    render json: current_user.as_json(only: [:id, :name, :email, :created_at])
  end
end
