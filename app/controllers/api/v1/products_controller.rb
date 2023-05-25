class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    products = Product.all
    products_with_favorites = products.map do |product|
      {
        product: product.as_json(methods: [:image_url], include: { user: { only: :name } }),
        favorites_count: product.favorites_count,
        unfavorites_count: product.unfavorites_count
      }
    end
    render json: products_with_favorites
  end

  def show
    render json: {
      product: @product.as_json(methods: [:image_url], include: { user: { only: :name } }),
      favorites_count: @product.favorites_count,
      unfavorites_count: @product.unfavorites_count
    }
  end

  def create
    product_params_with_current_user = product_params.merge(user_id: current_user.id, prefecture: current_user.prefecture)
    product = Product.new(product_params_with_current_user)
    if product.save
      render json: product, status: :created
    else
      render json: { error: '農産物を出品できませんでした' }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: { error: '農産物を編集できませんでした' }, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      head :no_content
    else
      render json: { error: '農産物を削除できませんでした' }, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      render json: { error: '農産物が見つかりません' }, status: :not_found
      return
    end
  end

  def product_params
    params.permit(:name, :category, :price, :description, :image)
  end
end
