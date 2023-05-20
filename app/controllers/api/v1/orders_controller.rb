class Api::V1::OrdersController < ApplicationController
  before_action :set_order_detail, only: %i[update]

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
    order.assign_attributes(
      user_id: current_user.id,
      zipcode: current_user.zipcode,
      street: current_user.street,
      building: current_user.building
    )
    if order.save
      create_order_details(order.id)
      current_user.carts.destroy_all
    else
      render json: { error: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    order_detail = OrderDetail.find(params[:id])
    render json: order_detail.as_json(include: { product: {}, order: { include: { user: { only: :name } } } })
  end

  def update
    if @order_detail.update(order_params)
      render json: @order_detail
    else
      render json: { error: @order_detail.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_order_detail
    @order_detail = OrderDetail.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:billing_amount, :status)
  end

  def create_order_details(order_id)
    order_details = current_user.carts.map do |cart|
      {
        order_id: order_id,
        product_id: cart.product_id,
        price: cart.product.price,
        quantity: cart.quantity,
        status: 0
      }
    end
    OrderDetail.insert_all(order_details)
  end
end
