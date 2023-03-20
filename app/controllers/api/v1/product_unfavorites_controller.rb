class Api::V1::ProductUnfavoritesController < ApplicationController

  def index
    productUnfavorites = ProductUnfavorite.all
    render json: productUnfavorites
  end

  def create
    productUnfavorite = ProductUnfavorite.new(productUnfavorite_params)
    productUnfavorite.save!
    if  productFavorite = ProductFavorite.find_by(productUnfavorite_params)
        productFavorite.destroy!
    end
  end

  def show
    unfavorite = ProductUnfavorite.where(user_id: params[:id]).pluck(:product_id)
    productUnfavorite = Product.find(unfavorite)
    render json: productUnfavorite
  end

  def destroy
    productUnfavorite = ProductUnfavorite.find_by(productUnfavorite_params)
    productUnfavorite.destroy!
  end

  def productUnfavorite_params
    params.permit(:product_id, :user_id)
  end
end
