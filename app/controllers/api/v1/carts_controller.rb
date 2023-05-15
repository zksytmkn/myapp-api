class Api::V1::CartsController < ApplicationController
  before_action :set_cart, only: %i[update destroy]

  def index
    carts = Cart.includes(:product).where(user_id: current_user.id)
    render json: carts, include: { product: { methods: [:favorites_count, :unfavorites_count] } }
  end

  def create
    product = Product.find(params[:product_id])
    if product.stock < params[:quantity].to_i
      render json: { error: 'Not enough stock' }, status: :unprocessable_entity
      return
    end

    product.update!(stock: product.stock - params[:quantity].to_i)

    cart = Cart.new(cart_params.merge(user_id: current_user.id))
    if cart.save
      render json: cart, status: :created
    else
      render json: { error: cart.errors.full_messages }, status: :unprocessable_entity
    end
  end  

  def update
    product = Product.find(@cart.product_id)
    if product.stock < params[:quantity].to_i - @cart.quantity
      render json: { error: 'Not enough stock' }, status: :unprocessable_entity
      return
    end

    product.update!(stock: product.stock - params[:quantity].to_i + @cart.quantity)

    if @cart.update(cart_params)
      render json: @cart
    else
      render json: { error: @cart.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @cart
      Product.transaction do
        product = @cart.product
        product.stock += @cart.quantity
        product.save!
        @cart.destroy
      end
      render json: { message: 'Cart item has been deleted.' }, status: :ok
    else
      render json: { error: 'Cart item not found.' }, status: :not_found
    end
  end


  private

  def set_cart
    @cart = Cart.find_by(id: params[:id])
  end

  def cart_params
    params.permit(:product_id, :quantity)
  end
end
