class Api::V1::InvitationsController < ApplicationController

  def index
    invited_communities = Community.joins(:invitations).where(invitations: { invited_id: current_user.id })
    render json: invited_communities
  end

  def create
    Invitation.create!(invitation_params.merge(inviting_id: current_user.id))
  end

  private

  def invitation_params
    params.require(:invitation).permit(:invited_id, :community_id)
  end
end
