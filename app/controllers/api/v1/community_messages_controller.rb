class Api::V1::CommunityMessagesController < ApplicationController

  def index
    render json: CommunityMessage.where(community_id: params[:community_id]), include: [:user]
  end

  def create
    CommunityMessage.create!(community_message_params)
  end

  private

  def community_message_params
    params.permit(:content, :user_id).merge(community_id: params[:community_id])
  end
end
