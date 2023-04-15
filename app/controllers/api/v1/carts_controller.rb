class Api::V1::CartsController < ApplicationController
  before_action :set_cart, only: %i[update destroy]

  def index
    carts = Cart.where(user_id: current_user.id)
    render json: carts, include: [:product]
  end

  def create
    Cart.create!(cart_params)
  end

  def update
    @cart.update!(cart_params)
  end

  def destroy
    @cart.destroy!
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end

  def cart_params
    params.permit(:user_id, :product_id, :quantity)
  end
end
