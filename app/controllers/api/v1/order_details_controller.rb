class Api::V1::OrderDetailsController < ApplicationController

  def orderDetail_params
    params.permit(:order_id, :product_id, :price, :quantity)
  end
end
