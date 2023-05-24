class Api::V1::OrderDetailsController < ApplicationController
  before_action :set_order_detail, only: %i[update]

  def update
    if @order_detail.update(order_detail_params)
      render json: @order_detail
    else
      render json: { error: '注文ステータスを更新できませんでした' }, status: :unprocessable_entity
    end
  end

  private

  def set_order_detail
    @order_detail = OrderDetail.find_by(id: params[:id])

    unless @order_detail
      render json: { error: '注文詳細が見つかりません' }, status: :not_found
    end
  end

  def order_detail_params
    params.require(:order_detail).permit(:status)
  end
end
