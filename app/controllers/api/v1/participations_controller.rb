class Api::V1::ParticipationsController < ApplicationController
  before_action :set_participation, only: [:destroy]

  def index
    participated_communities = Community.joins(:participations).where(participations: { user_id: current_user.id })
    render json: participated_communities
  end

  def create
    participation = Participation.new(participation_params.merge(user_id: current_user.id))

    if participation.save
      render json: participation, status: :created
    else
      render json: { error: participation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @participation.destroy
      render status: :no_content
    else
      render json: { error: 'コミュニティを退会できませんでした' }, status: :unprocessable_entity
    end
  end

  private

  def set_participation
    @participation = Participation.find_by(community_id: params[:id], user_id: current_user.id)

    unless @participation
      render json: { error: '参加情報が見つかりません' }, status: :not_found
    end
  end

  def participation_params
    params.require(:participation).permit(:community_id)
  end
end
