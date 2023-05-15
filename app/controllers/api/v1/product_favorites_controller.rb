class Api::V1::ProductFavoritesController < ApplicationController
  before_action :set_product_favorite, only: [:destroy]

  def index
    favorite_ids = ProductFavorite.where(user_id: current_user.id).pluck(:product_id)
    product_favorites = Product.find(favorite_ids)

    product_favorites_with_counts = product_favorites.map do |product|
      {
        product: product,
        favorites_count: product.favorites_count,
        unfavorites_count: product.unfavorites_count
      }
    end

    render json: product_favorites_with_counts
  end

  def create
    product_favorite_params_with_current_user = product_favorite_params.merge(user_id: current_user.id)
    product_favorite = ProductFavorite.create!(product_favorite_params_with_current_user)
    product_unfavorite = ProductUnfavorite.find_by(product_favorite_params_with_current_user)
    product_unfavorite&.destroy!
    render json: product_favorite, status: :created
  end

  def destroy
    @product_favorite.destroy!
    head :no_content
  end

  private

  def product_favorite_params
    params.permit(:product_id)
  end

  def set_product_favorite
    @product_favorite = ProductFavorite.find_by!(product_id: params[:id], user_id: current_user.id)
  end
end
