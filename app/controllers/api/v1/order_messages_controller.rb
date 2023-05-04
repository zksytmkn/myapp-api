class Api::V1::OrderMessagesController < ApplicationController

  def index
    render json: OrderMessage.where(order_id: params[:order_id]), include: [:user]
  end

  def create
    order_message = OrderMessage.create!(order_message_params)
    render json: order_message, status: :created
  end  

  private

  def order_message_params
    params.require(:order_message).permit(:content).merge(user_id: current_user.id, order_id: params[:order_id])
  end  
end
