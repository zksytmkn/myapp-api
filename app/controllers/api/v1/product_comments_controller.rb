class Api::V1::ProductCommentsController < ApplicationController

  def show
    productComments = ProductComment.where(product_id: params[:id])
    render json: productComments, include: [:user]
  end

  def create
    productComment = ProductComment.new(productComment_params)
    productComment.save!
    
  end

  def destroy
    productComment = ProductComment.find(params[:id])
    productComment.destroy!
  end

  def productComment_params
    params.permit(:productComment_content, :product_id, :user_id)
  end
end
