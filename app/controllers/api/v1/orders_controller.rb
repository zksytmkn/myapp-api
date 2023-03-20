class Api::V1::OrdersController < ApplicationController

  def create
    order = Order.new(order_params)
    if order.save
      Cart.all.each do |cart|
        orderDetail = OrderDetail.new
        orderDetail.order_id = order.id
        orderDetail.product_id = cart.product_id
        cartProductId = Cart.where(id: cart.id).pluck(:product_id)
        orderDetail.price = Product.find_by(id: cartProductId).price
        orderDetail.quantity = cart.quantity
        orderDetail.save
      end
      Cart.destroy_all
    end
  end

  def show
    order = Order.where(user_id: params[:id])
    orderId = order.pluck(:id)
    orderDetail = OrderDetail.where(order_id: orderId).as_json(include: [:product])
    render json: { order: order, orderDetail: orderDetail}
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
  end

  def order_params
    params.permit(:user_id, :billing_amount, :status)
  end
end
