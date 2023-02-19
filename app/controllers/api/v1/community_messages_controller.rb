class Api::V1::CommunityMessagesController < ApplicationController

  def show
    communityMessages = CommunityMessage.where(community_id: params[:id])
    render json: communityMessages, include: [:user]
  end

  def create
    communityMessage = CommunityMessage.new(communityMessage_params)
    communityMessage.save!
    
  end

  def destroy
    communityMessage = CommunityMessage.find(params[:id])
    communityMessage.destroy!
  end

  def communityMessage_params
    params.permit(:communityMessage_content, :community_id, :user_id)
  end
end
