class Api::V1::ParticipationsController < ApplicationController
  before_action :set_participation, only: [:destroy]

  def index
    community_ids = Participation.where(user_id: current_user.id).pluck(:community_id)
    render json: Community.find(community_ids)
  end

  def create
    Participation.create!(participation_params)
  end

  def destroy
    @participation.destroy!
  end

  private

  def set_participation
    @participation = Participation.find_by(community_id: params[:community_id], user_id: params[:user_id])
  end

  def participation_params
    params.permit(:user_id, :community_id)
  end
end
