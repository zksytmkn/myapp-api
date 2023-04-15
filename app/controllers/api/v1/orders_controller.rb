class Api::V1::OrdersController < ApplicationController

  def index
    buyer_id = Order.where(user_id: current_user.id).pluck(:id)
    buyer = OrderDetail.where(order_id: buyer_id).where.not(status: 3).as_json(include: [:product, :order])
    seller_id = Product.where(user_id: current_user.id).pluck(:id)
    seller = OrderDetail.where(product_id: seller_id).where.not(status: 3).as_json(include: [:product, :order])
    close_id = OrderDetail.where(order_id: buyer_id).or(OrderDetail.where(product_id: seller_id)).pluck(:id)
    close = OrderDetail.where(id: close_id).where(status: 3).as_json(include: [:product, :order])
    render json: { buyer: buyer, seller: seller, close: close }
  end

  def create
    order = Order.new(order_params)
    if order.save
      create_order_details(order.id)
      Cart.destroy_all
    end
  end

  def show
    order_detail = OrderDetail.find_by(id: params[:id]).as_json(include: [:product, order: { include: :user }])
    render json: order_detail
  end

  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
  end

  private

  def order_params
    params.permit(:user_id, :billing_amount, :zipcode, :street, :building)
  end

  def order_detail_params
    params.permit(:order_id, :product_id, :price, :quantity, :status)
  end

  def create_order_details(order_id)
    Cart.all.each do |cart|
      order_detail = OrderDetail.new
      order_detail.order_id = order_id
      order_detail.product_id = cart.product_id
      cart_product_id = Cart.where(id: cart.id).pluck(:product_id)
      order_detail.price = Product.find_by(id: cart_product_id).price
      order_detail.quantity = cart.quantity
      order_detail.status = 0
      order_detail.save
    end
  end
end
