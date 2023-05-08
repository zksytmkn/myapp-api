class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_active_user, only: [:create, :update, :destroy]
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    products = Product.all
    products_with_favorites = products.map do |product|
      {
        product: product,
        favorites_count: ProductFavorite.where(product_id: product.id).count,
        unfavorites_count: ProductUnfavorite.where(product_id: product.id).count
      }
    end
    render json: products_with_favorites
  end

  def create
    product = Product.create!(product_params)
  end

  def show
    favorites_count = ProductFavorite.where(product_id: @product.id).count
    unfavorites_count = ProductUnfavorite.where(product_id: @product.id).count
    render json: {
      product: @product.as_json(methods: [:image_url], include: [:user]),
      favorites_count: favorites_count,
      unfavorites_count: unfavorites_count
    }
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
