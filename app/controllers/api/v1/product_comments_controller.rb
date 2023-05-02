class Api::V1::ProductCommentsController < ApplicationController
  before_action :set_product_comment, only: [:destroy]

  def index
    product_comments = ProductComment.where(product_id: params[:product_id])
    render json: product_comments, include: [:user]
  end

  def create
    product_comment = ProductComment.create!(product_comment_params)
  end

  def destroy
    @product_comment.destroy!
  end

  private

  def product_comment_params
    params.permit(:content, :product_id, :user_id)
  end

  def set_product_comment
    @product_comment = ProductComment.find(params[:id])
  end
end
