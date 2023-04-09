class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_active_user
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    products = Product.all
    render_products(products)
  end

  def create
    product = Product.create!(product_params)
  end

  def show
    render_product(@product)
  end

  def update
    @product.update!(product_params)
  end

  def destroy
    @product.destroy!
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.permit(:name, :user_id, :category, :prefecture, :price, :quantity, :stock, :description, :image)
  end

  def render_product(product)
    render json: product, methods: [:image_url], include: [:user]
  end

  def render_products(products)
    render json: products, methods: [:image_url], include: [:user]
  end
end
