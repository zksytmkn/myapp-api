class Api::V1::OrdersController < ApplicationController

  def index
    buyerId = Order.where(user_id: current_user.id).pluck(:id)
    buyer = OrderDetail.where(order_id: buyerId).where.not(status: 3).as_json(include: [:product, :order])
    sellerId = Product.where(user_id: current_user.id).pluck(:id)
    seller = OrderDetail.where(product_id: sellerId).where.not(status: 3).as_json(include: [:product, :order])
    closeId = OrderDetail.where(order_id: buyerId).or(OrderDetail.where(product_id: sellerId)).pluck(:id)
    close = OrderDetail.where(id: closeId).where(status: 3).as_json(include: [:product, :order])
    render json: { buyer: buyer, seller: seller, close: close}
  end

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
        orderDetail.status = 0
        orderDetail.save
      end
      Cart.destroy_all
    end
  end

  def show
    orderDetail = OrderDetail.find_by(id: params[:id]).as_json(include: [:product, order: { include: :user }])
    render json: orderDetail
  end

  def update
    orderDetail = OrderDetail.find(params[:id])
    orderDetail.update(orderDetail_params)
  end

  def order_params
    params.permit(:user_id, :billing_amount, :zipcode, :street, :building)
  end

  def orderDetail_params
    params.permit(:order_id, :product_id, :price, :quantity, :status)
  end
end
