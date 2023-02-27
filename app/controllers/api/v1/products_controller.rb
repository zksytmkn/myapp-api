class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_active_user

  def index
    products = Product.all
    render json: products, methods: [:image_url], include: [:user]
  end

  def new
  end

  def create
    product = Product.new(product_params)
    product.save!
  end

  def show
    product = Product.find(params[:id])
    render json: product, include: [:user]
  end

  def edit
  end

  def update
    product = Product.find(params[:id])
    product.update(product_params)
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy!
  end

  def product_params
    params.permit(:name, :user_id, :type, :prefecture, :price, :quantity, :inventory, :text, :image)
  end
end