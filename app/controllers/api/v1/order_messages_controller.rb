class Api::V1::OrderMessagesController < ApplicationController

  def index
    render json: OrderMessage.where(order_id: params[:id]), include: [:user]
  end

  def create
    order_message = OrderMessage.create!(order_message_params)
    render json: order_message, status: :created
  end  

  private

  def order_message_params
    params.permit(:content, :order_id, :user_id)
  end
end
