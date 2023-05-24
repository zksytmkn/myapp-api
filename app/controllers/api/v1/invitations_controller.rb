class Api::V1::InvitationsController < ApplicationController

  def index
    invited_communities = Community.joins(:invitations).where(invitations: { invited_id: current_user.id })
    render json: invited_communities
  end

  def create
    invitation = Invitation.new(invitation_params.merge(inviting_id: current_user.id))
    if invitation.save
      render json: invitation, status: :created
    else
      render json: { error: 'コミュニティに招待できませんでした' }, status: :unprocessable_entity
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:invited_id, :community_id)
  end
end
