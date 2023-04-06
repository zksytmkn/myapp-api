class Api::V1::ProductUnfavoritesController < ApplicationController
  before_action :set_product_unfavorite, only: [:destroy]

  def index
    product_unfavorites = ProductUnfavorite.all
    render json: product_unfavorites
  end

  def create
    product_unfavorite = ProductUnfavorite.new(product_unfavorite_params)

    if product_unfavorite.save
      product_favorite = ProductFavorite.find_by(product_unfavorite_params)
      product_favorite&.destroy!
      render json: product_unfavorite, status: :created
    else
      render json: product_unfavorite.errors, status: :unprocessable_entity
    end
  end

  def show
    unfavorites = ProductUnfavorite.where(user_id: params[:id]).pluck(:product_id)
    products = Product.find(unfavorites)
    render json: products
  end

  def destroy
    @product_unfavorite.destroy
    head :no_content
  end

  private

  def product_unfavorite_params
    params.permit(:product_id, :user_id)
  end

  def set_product_unfavorite
    @product_unfavorite = ProductUnfavorite.find_by!(product_id: params[:product_id], user_id: params[:user_id])
  end
end
