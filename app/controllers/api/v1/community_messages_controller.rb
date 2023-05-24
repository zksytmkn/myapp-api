class Api::V1::CommunityMessagesController < ApplicationController

  def index
    render json: CommunityMessage.where(community_id: params[:community_id]).as_json(include: { user: { only: :name } })
  end

  def create
    community_message = CommunityMessage.new(community_message_params)
  
    if community_message.save
      render json: community_message, status: :created
    else
      render json: { error: 'メッセージを送信できませんでした' }, status: :unprocessable_entity
    end
  end

  private

  def community_message_params
    params.require(:community_message).permit(:content).merge(user_id: current_user.id, community_id: params[:community_id])
  end  
end
