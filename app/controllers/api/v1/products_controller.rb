class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_active_user

  def index
    products = Product.all
    render json: products, methods: [:image_url]
  end

  def new
  end

  def create
    product = Product.new(product_params)
    product.save!
  end

  def show
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
    params.permit(:name, :seller, :type, :prefecture, :price, :quantity, :inventory, :text, :image)
  end
end