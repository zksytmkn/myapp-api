class Api::V1::CommunityMessagesController < ApplicationController

  def show
    render json: CommunityMessage.where(community_id: params[:id]), include: [:user]
  end

  def create
    CommunityMessage.create!(community_message_params)
  end

  private

  def community_message_params
    params.permit(:communityMessage_content, :community_id, :user_id)
  end
end
