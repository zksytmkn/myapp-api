class Api::V1::CommunitiesController < ApplicationController
  before_action :authenticate_active_user

  def index
    communities = Community.all
    render json: communities, methods: [:image_url], include: [:user]
  end

  def new
    community = Community.new
  end

  def create
    community = Community.new(community_params)
    community.save!
  end

  def show
    community = Community.find(params[:id]).as_json(methods: [:image_url], include: [:user])
    participation = Participation.where(community_id: params[:id]).pluck(:user_id)
    participatedUser = User.find(participation)
    invitation = Invitation.where(community_id: params[:id]).pluck(:user_id)
    invitedUser = User.find(invitation)
    render json: { community: community, participation: participatedUser, invitation: invitedUser }
  end

  def edit
  end

  def update
    community = Community.find(params[:id])
    community.update(community_params)
  end

  def destroy
    community = Community.find(params[:id])
    community.destroy!
  end

  def community_params
    params.permit(:name, :user_id, :text, :image )
  end
end