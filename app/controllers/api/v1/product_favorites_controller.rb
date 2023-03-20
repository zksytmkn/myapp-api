class Api::V1::ProductFavoritesController < ApplicationController

  def index
    productFavorites = ProductFavorite.all
    render json: productFavorites
  end

  def create
    productFavorite = ProductFavorite.new(productFavorite_params)
    productFavorite.save!
    if  productUnfavorite = ProductUnfavorite.find_by(productFavorite_params)
        productUnfavorite.destroy!
    end
  end

  def show
    favorite = ProductFavorite.where(user_id: params[:id]).pluck(:product_id)
    productFavorite = Product.find(favorite)
    render json: productFavorite
  end

  def destroy
    productFavorite = ProductFavorite.find_by(productFavorite_params)
    productFavorite.destroy!
  end

  def productFavorite_params
    params.permit(:product_id, :user_id)
  end
end
