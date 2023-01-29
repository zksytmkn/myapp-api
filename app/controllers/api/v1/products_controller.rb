class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_active_user
  before_action :set_product, only: [:show, :edit, :update, :delete]

  def index
    products = Product.all
    render json: products
  end

  def new
    product = Product.new
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
    if product.update(product_params)
      flash[:success] = "農産物を編集しました"
      redirect_to()
    else
      flash[:failure] = "農産物の編集に失敗しました"
      render :edit
    end
  end

  def destroy
    if product.destroy
      flash[:success] = "農産物を削除しました"
      redirect_to()
    else
      flash[:failure] = "農産物の削除に失敗しました"
      render :show
    end
  end

  def set_product
    product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :seller, :type, :region, :prefecture, :price, :quantity, :inventory, :text, :image)
  end
end