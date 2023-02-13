class Api::V1::ProductCommentsController < ApplicationController

  def show
    productComments = ProductComment.where(product_id: params[:id])
    render json: productComments, include: [:user]
  end

  def create
    productComment = ProductComment.new(productComment_params)
    productComment.save!
  end

  private
  def productComment_params
    params.require(:productComment).permit(:productComment_content, :product_id)
  end
end
