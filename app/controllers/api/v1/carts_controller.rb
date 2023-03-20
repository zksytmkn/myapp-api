class Api::V1::CartsController < ApplicationController

  def create
    cart = Cart.new(cart_params)
    cart.save!
  end

  def show
    cart = Cart.where(user_id: params[:id])
    render json: cart, include: [:product]
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
