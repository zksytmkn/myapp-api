class Api::V1::OrderMessagesController < ApplicationController

  def index
    render json: OrderMessage.where(order_id: params[:order_id]).as_json(include: { user: { only: :name } })
  end

  def create
    order_message = OrderMessage.new(order_message_params)

    if order_message.save
      render json: order_message, status: :created
    else
      render json: { error: order_message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def order_message_params
    params.require(:order_message).permit(:content).merge(user_id: current_user.id, order_id: params[:order_id])
  end
end
