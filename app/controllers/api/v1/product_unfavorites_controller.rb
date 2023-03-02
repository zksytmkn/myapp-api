class Api::V1::ProductUnfavoritesController < ApplicationController

  def create
    productUnfavorite = ProductUnfavorite.new(productUnfavorite_params)
    productUnfavorite.save!
  end

  def productUnfavorite_params
    params.permit(:product_id, :user_id)
  end
end
