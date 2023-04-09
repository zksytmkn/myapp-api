class Api::V1::ProductFavoritesController < ApplicationController
  before_action :set_product_favorite, only: [:destroy]

  def index
    product_favorites = ProductFavorite.all
    render json: product_favorites
  end

  def create
    product_favorite = ProductFavorite.create!(product_favorite_params)
    product_unfavorite = ProductUnfavorite.find_by(product_favorite_params)
    product_unfavorite&.destroy!
    render json: product_favorite, status: :created
  end

  def show
    favorites = ProductFavorite.where(user_id: params[:id]).pluck(:product_id)
    products = Product.find(favorites)
    render json: products
  end

  def destroy
    @product_favorite.destroy!
    head :no_content
  end

  private

  def product_favorite_params
    params.permit(:product_id, :user_id)
  end

  def set_product_favorite
    @product_favorite = ProductFavorite.find_by!(product_id: params[:product_id], user_id: params[:user_id])
  end
end
