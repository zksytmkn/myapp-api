class Api::V1::UsersController < ApplicationController
  before_action :authenticate_active_user

  def index
    users = User.all
    render json: users, methods: [:image_url]
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
