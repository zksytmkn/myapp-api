class Api::V1::ParticipationsController < ApplicationController

  def create
    participation = Participation.new(participation_params)
    participation.save!
  end

  def show
    participation = Participation.where(user_id: params[:id]).pluck(:community_id)
    participatedCommunity = Community.find(participation)
    render json: participatedCommunity
  end

  def destroy
    participation = Participation.find_by(participation_params)
    participation.destroy!
  end

  def participation_params
    params.permit(:user_id, :community_id)
  end
end
