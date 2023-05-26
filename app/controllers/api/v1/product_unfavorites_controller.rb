class Api::V1::ProductUnfavoritesController < ApplicationController
  before_action :set_product_unfavorite, only: [:destroy]

  def index
    unfavorite_ids = ProductUnfavorite.where(user_id: current_user.id).pluck(:product_id)
    product_unfavorites = Product.find(unfavorite_ids)
    render json: product_unfavorites
  end

  def create
    product_unfavorite_params_with_current_user = product_unfavorite_params.merge(user_id: current_user.id)
    product_unfavorite = ProductUnfavorite.new(product_unfavorite_params_with_current_user)
    
    if product_unfavorite.save
      product_favorite = ProductFavorite.find_by(product_unfavorite_params_with_current_user)
      product_favorite&.destroy
      render json: product_unfavorite, status: :created
    else
      render json: { error: product_unfavorite.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @product_unfavorite
      @product_unfavorite.destroy
      head :no_content
    else
      render json: { error: 'ないねを解除できませんでした' }, status: :unprocessable_entity
    end
  end

  private

  def product_unfavorite_params
    params.require(:product_unfavorite).permit(:product_id)
  end

  def set_product_unfavorite
    @product_unfavorite = ProductUnfavorite.find_by(product_id: params[:id], user_id: current_user.id)
    
    unless @product_unfavorite
      render json: { error: 'ないねが見つかりません' }, status: :not_found
      return
    end
  end
end
