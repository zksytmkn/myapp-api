class Api::V1::ProductCommentsController < ApplicationController

  def create
    productComment = ProductComment.new(productComment_params)
    productComment.save!
  end

  private
  def productComment_params
    params.require(:productComment).permit(:productComment_content, :product_id)
  end
end
