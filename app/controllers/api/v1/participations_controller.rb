class Api::V1::ParticipationsController < ApplicationController

  def index
    participation = Participation.where(user_id: current_user.id).pluck(:community_id)
    participatedCommunity = Community.find(participation)
    render json: participatedCommunity
  end

  def create
    participation = Participation.new(participation_params)
    participation.save!
  end

  def destroy
    participation = Participation.find_by(participation_params)
    participation.destroy!
  end

  def participation_params
    params.permit(:user_id, :community_id)
  end
end
