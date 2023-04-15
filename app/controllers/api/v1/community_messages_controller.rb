class Api::V1::CommunityMessagesController < ApplicationController
  before_action :set_community_message, only: %i[destroy]

  def show
    render json: CommunityMessage.where(community_id: params[:id]), include: [:user]
  end

  def create
    CommunityMessage.create!(community_message_params)
  end

  def destroy
    @community_message.destroy!
  end

  private

  def set_community_message
    @community_message = CommunityMessage.find(params[:id])
  end

  def community_message_params
    params.permit(:communityMessage_content, :community_id, :user_id)
  end
end
