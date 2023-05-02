class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: %i[show update]

  def index
    buyer_orders = current_user.orders.includes(order_details: :product)
    seller_orders = Order.joins(order_details: :product).where(products: { user_id: current_user.id })
    closed_orders = OrderDetail.where(status: 3).includes(:product, :order)

    render json: {
      buyer: buyer_orders.as_json(include: { order_details: { include: :product } }),
      seller: seller_orders.as_json(include: { order_details: { include: :product } }),
      close: closed_orders.as_json(include: [:product, :order])
    }
  end

  def create
    order = current_user.orders.new(order_params)
    if order.save
      create_order_details(order.id)
      current_user.carts.destroy_all
    end
  end

  def show
    render json: @order.as_json(include: { order_details: { include: :product } })
  end

  def update
    @order.update!(order_params)
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.permit(:user_id, :billing_amount, :zipcode, :street, :building)
  end

  def create_order_details(order_id)
    current_user.carts.each do |cart|
      order_detail = OrderDetail.new
      order_detail.order_id = order_id
      order_detail.product_id = cart.product_id
      order_detail.price = cart.product.price
      order_detail.quantity = cart.quantity
      order_detail.status = 0
      order_detail.save
    end
  end
end
