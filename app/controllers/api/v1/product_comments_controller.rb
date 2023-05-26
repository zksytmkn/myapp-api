class Api::V1::ProductCommentsController < ApplicationController
  before_action :set_product, only: [:index, :create]
  before_action :set_product_comment, only: [:destroy]

  def index
    product_comments = @product.product_comments.includes(:user).map do |product_comment|
      product_comment.as_json.merge(user: product_comment.user.as_json(only: :name, methods: :image_url))
    end
    render json: product_comments
  end

  def create
    product_comment = @product.product_comments.new(product_comment_params)

    if product_comment.save
      render json: product_comment, status: :created
    else
      render json: { error: product_comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @product_comment
      @product_comment.destroy
      head :no_content
    else
      render json: { error: 'コメントを削除できませんでした' }, status: :not_found
    end
  end

  private

  def set_product
    @product = Product.find_by(id: params[:product_id])
    if @product.nil?
      render json: { error: '農産物が見つかりません' }, status: :not_found
      return
    end
  end

  def set_product_comment
    @product_comment = ProductComment.find_by(id: params[:id])
    if @product_comment.nil?
      render json: { error: 'コメントが見つかりません' }, status: :not_found
      return
    end
  end

  def product_comment_params
    params.require(:product_comment).permit(:content).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
