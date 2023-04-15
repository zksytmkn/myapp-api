class Api::V1::OrderDetailsController < ApplicationController

  def order_detail_params
    params.permit(:order_id, :product_id, :price, :quantity, :status)
  end
end
