class Api::V1::ProductFavoritesController < ApplicationController

  def create
    productFavorite = ProductFavorite.new(productFavorite_params)
    productFavorite.save!
  end

  def productFavorite_params
    params.permit(:product_id, :user_id)
  end
end
