class Api::V1::ProductCommentsController < ApplicationController
  before_action :set_product, only: [:index, :create]
  before_action :set_product_comment, only: [:destroy]

  def index
    product_comments = @product.product_comments
    render json: product_comments, include: [:user]
  end

  def create
    product_comment = @product.product_comments.create!(product_comment_params)
    render json: product_comment, status: :created
  end

  def destroy
    @product_comment.destroy!
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_product_comment
    @product_comment = ProductComment.find(params[:id])
  end

  def product_comment_params
    params.require(:product_comment).permit(:content).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
