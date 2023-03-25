class Api::V1::CartsController < ApplicationController

  def index
    cart = Cart.where(user_id: current_user.id)
    render json: cart, include: [:product]
  end

  def create
    cart = Cart.new(cart_params)
    cart.save!
  end

  def update
    cart = Cart.find(params[:id])
    cart.update!(cart_params)
  end

  def destroy
    cart = Cart.find(params[:id])
    cart.destroy!
  end

  def cart_params
    params.permit(:user_id, :product_id, :quantity)
  end
end
