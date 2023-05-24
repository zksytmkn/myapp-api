class Api::V1::CartsController < ApplicationController
  before_action :set_cart, only: %i[update destroy]

  def index
    carts = Cart.includes(:product).where(user_id: current_user.id)
    render json: carts, include: { product: { methods: [:favorites_count, :unfavorites_count] } }
  end

  def create
    product = Product.find_by(id: cart_params[:product_id])
    if product.nil?
      render json: { error: '農産物が見つかりません' }, status: :not_found
      return
    end
    
    if product.stock < cart_params[:quantity].to_i
      render json: { error: '在庫が不足しています' }, status: :unprocessable_entity
      return
    end

    product.update!(stock: product.stock - cart_params[:quantity].to_i)

    cart = Cart.new(cart_params.merge(user_id: current_user.id))
    if cart.save
      render json: cart, status: :created
    else
      render json: { error: 'カートに入れられませんでした' }, status: :unprocessable_entity
    end
  end

  def update
    product = Product.find_by(id: @cart.product_id)
    if product.nil?
      render json: { error: '農産物が見つかりません' }, status: :not_found
      return
    end
    
    if product.stock < cart_params[:quantity].to_i - @cart.quantity
      render json: { error: '在庫が不足しています' }, status: :unprocessable_entity
      return
    end

    product.update!(stock: product.stock - cart_params[:quantity].to_i + @cart.quantity)

    if @cart.update(cart_params)
      render json: @cart
    else
      render json: { error: 'カートに入れられませんでした' }, status: :unprocessable_entity
    end
  end

  def destroy
    if @cart
      Product.transaction do
        product = @cart.product
        if product.nil?
          render json: { error: '農産物が見つかりません' }, status: :not_found
          return
        end
        product.stock += @cart.quantity
        product.save!
        @cart.destroy
      end
      render json: { message: 'カートから削除しました' }, status: :ok
    else
      render json: { error: 'カートから削除できませんでした' }, status: :not_found
    end
  end


  private

  def set_cart
    @cart = Cart.find_by(id: params[:id])
    if @cart.nil?
      render json: { error: 'カートに農産物が見つかりません' }, status: :not_found
      return
    end
  end

  def cart_params
    params.require(:cart).permit(:product_id, :quantity)
  end  
end

