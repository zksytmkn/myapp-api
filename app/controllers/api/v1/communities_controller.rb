class Api::V1::CommunitiesController < ApplicationController
  before_action :authenticate_active_user
  before_action :set_community, only: [:show, :update, :destroy]

  def index
    render json: Community.all, methods: [:image_url]
  end

  def create
    Community.create!(community_params)
  end

  def show
    participation_user_ids = Participation.where(community_id: @community.id).pluck(:user_id)
    invitation_data = Invitation.where(community_id: @community.id)
    
    render json: {
      community: @community.as_json(methods: [:image_url], include: [:user]),
      participation: User.find(participation_user_ids),
      invited: User.find(invitation_data.pluck(:invited_id)),
      inviting: User.find_by(id: invitation_data.where(invited_id: current_user.id).pluck(:inviting_id))
    }
  end

  def update
    @community.update(community_params)
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
