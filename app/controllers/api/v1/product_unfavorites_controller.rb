class Api::V1::ProductUnfavoritesController < ApplicationController
  before_action :set_product_unfavorite, only: [:destroy]

  def index
    unfavorite_ids = ProductUnfavorite.where(user_id: current_user.id).pluck(:product_id)
    product_unfavorites = Product.find(unfavorite_ids)
    render json: product_unfavorites
  end

  def create
    product_unfavorite_params_with_current_user = product_unfavorite_params.merge(user_id: current_user.id)
    product_unfavorite = ProductUnfavorite.create!(product_unfavorite_params_with_current_user)
    product_favorite = ProductFavorite.find_by(product_unfavorite_params_with_current_user)
    product_favorite&.destroy!
    render json: product_unfavorite, status: :created
  end

  def destroy
    @product_unfavorite.destroy!
    head :no_content
  end

  private

  def product_unfavorite_params
    params.permit(:product_id).merge(user_id: current_user.id)
  end

  def set_product_unfavorite
    @product_unfavorite = ProductUnfavorite.find_by!(product_id: params[:product_id], user_id: current_user.id)
  end
end
