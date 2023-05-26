class Api::V1::CommunitiesController < ApplicationController
  before_action :set_community, only: [:show, :update, :destroy]

  def index
    render json: Community.all, methods: [:image_url], include: { user: { only: :name } }
  end

  def show
    participation_users = User.joins(:participations).where(participations: { community_id: @community.id })
    invited_users = User.joins(:invited_invitations).where(invitations: { community_id: @community.id })
    inviting_user = User.joins(:inviting_invitations).find_by(invitations: { community_id: @community.id, invited_id: current_user.id })

    render json: {
      community: @community.as_json(methods: [:image_url], include: { user: { only: :name } }),
      participation: participation_users,
      invited: invited_users,
      inviting: inviting_user
    }
  end

  def create
    community_params_with_user = community_params.merge(user_id: current_user.id)
    community = Community.new(community_params_with_user)
    if community.save
      render json: community, status: :created
    else
      render json: { error: community.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @community.update(community_params)
      render json: @community
    else
      render json: { error: @community.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @community.destroy
      render json: { message: 'コミュニティを削除しました' }, status: :ok
    else
      render json: { error: 'コミュニティを削除できませんでした' }, status: :unprocessable_entity
    end
  end

  private

  def set_community
    @community = Community.find_by(id: params[:id])
    if @community.nil?
      render json: { error: 'コミュニティが見つかりません' }, status: :not_found
      return
    end
  end

  def community_params
    params.permit(:name, :description, :image)
  end  
end
