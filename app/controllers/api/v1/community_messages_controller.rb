class Api::V1::CommunityMessagesController < ApplicationController

  def index
    render json: CommunityMessage.where(community_id: params[:community_id]), include: [:user]
  end

  def create
    community_message = CommunityMessage.create!(community_message_params)
    render json: community_message, status: :created
  end

  private

  def community_message_params
    params.require(:community_message).permit(:content).merge(user_id: current_user.id, community_id: params[:community_id])
  end  
end
