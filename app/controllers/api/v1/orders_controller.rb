class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: %i[update]

  def index
    buyer_order_details = OrderDetail.joins(:order).where(orders: { user_id: current_user.id }).includes(:product, :order)
    seller_order_details = OrderDetail.joins(:product).where(products: { user_id: current_user.id }).includes(:product, :order)
    closed_order_details = OrderDetail.where(status: 3).includes(:product, :order)
  
    render json: {
      buyer: buyer_order_details.as_json(include: [:product, :order]),
      seller: seller_order_details.as_json(include: [:product, :order]),
      close: closed_order_details.as_json(include: [:product, :order])
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
    order_detail = OrderDetail.find(params[:id])
    render json: order_detail.as_json(include: { product: {}, order: { include: :user } })
  end  

  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update!(status: params[:status])
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.permit(:user_id, :billing_amount, :zipcode, :street, :building, :status)
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
