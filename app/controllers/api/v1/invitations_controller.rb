class Api::V1::InvitationsController < ApplicationController

  def index
    invitation = Invitation.where(invited_id: current_user.id).pluck(:community_id)
    invitedCommunity = Community.find(invitation)
    render json: invitedCommunity
  end

  def create
    invitation = Invitation.new(invitation_params)
    invitation.save!
  end

  def destroy
    invitation = Invitation.find_by(invitation_params)
    invitation.destroy!
  end

  def invitation_params
    params.permit(:inviting_id, :invited_id, :community_id)
  end
end
