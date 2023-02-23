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
    participation = Participation.where(user_id: params[:id]).pluck(:community_id)
    participatedCommunity = Community.find(participation)
    invitation = Invitation.where(user_id: params[:id]).pluck(:community_id)
    invitedCommunity = Community.find(invitation)
    render json: { participation: participatedCommunity, invitation: invitedCommunity }
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
