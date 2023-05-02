class Api::V1::CommunitiesController < ApplicationController
  before_action :authenticate_active_user
  before_action :set_community, only: [:show, :update, :destroy]

  def index
    render json: Community.all, methods: [:image_url], include: [:user]
  end

  def create
    community = Community.create!(community_params)
    render json: community, status: :created
  end  

  def show
    participation_users = User.joins(:participations).where(participations: { community_id: @community.id })
    invited_users = User.joins(:invitations).where(invitations: { community_id: @community.id, inviting_id: current_user.id })
    inviting_user = User.joins(:invitations).find_by(invitations: { community_id: @community.id, invited_id: current_user.id })
  
    render json: {
      community: @community.as_json(methods: [:image_url], include: [:user]),
      participation: participation_users,
      invited: invited_users,
      inviting: inviting_user
    }
  end

  def update
    @community.update!(community_params)
    render json: @community
  end

  def destroy
    @community.destroy!
  end

  private

  def set_community
    @community = Community.find(params[:id])
  end

  def community_params
    params.permit(:name, :user_id, :description, :image)
  end
end
