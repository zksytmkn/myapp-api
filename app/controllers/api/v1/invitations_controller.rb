class Api::V1::InvitationsController < ApplicationController

  def create
    invitation = Invitation.new(invitation_params)
    invitation.save!
  end

  def show
    invitation = Invitation.where(user_id: params[:id]).pluck(:community_id)
    invitedCommunity = Community.find(invitation)
    render json: invitedCommunity
  end

  def destroy
    invitation = Invitation.find_by(invitation_params)
    invitation.destroy!
  end

  def invitation_params
    params.permit(:user_id, :community_id)
  end
end
