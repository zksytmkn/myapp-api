class Api::V1::InvitationsController < ApplicationController
  before_action :set_invitation, only: %i[destroy]

  def index
    invited_community_ids = Invitation.where(invited_id: current_user.id).pluck(:community_id)
    invited_communities = Community.find(invited_community_ids)
    render json: invited_communities
  end

  def create
    Invitation.create!(invitation_params)
  end

  def destroy
    @invitation.destroy!
  end

  private

  def set_invitation
    @invitation = Invitation.find_by(invitation_params)
  end

  def invitation_params
    params.permit(:inviting_id, :invited_id, :community_id)
  end
end
