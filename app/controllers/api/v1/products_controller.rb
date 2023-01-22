class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_active_user
  before_action :set_product, only: [:show, :edit, :update]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success] = "農産物を出品しました"
      redirect_to @product
    else
      flash[:danger] = "農産物の出品に失敗しました"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :text, :type, :region, :prefecture, :price, :inventory, :image)
  end
end