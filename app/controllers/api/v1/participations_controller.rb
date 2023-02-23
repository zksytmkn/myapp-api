class Api::V1::ParticipationsController < ApplicationController

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
