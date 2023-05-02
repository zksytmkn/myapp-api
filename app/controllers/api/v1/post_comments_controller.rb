class Api::V1::PostCommentsController < ApplicationController
  before_action :set_post_comment, only: [:destroy]

  def index
    post_comments = PostComment.where(post_id: params[:post_id])
    render json: post_comments, include: [:user]
  end

  def create
    post_comment = PostComment.create!(post_comment_params)
    render json: post_comment, status: :created
  end

  def destroy
    @post_comment.destroy!
  end

  private

  def set_post_comment
    @post_comment = PostComment.find(params[:id])
  end

  def post_comment_params
    params.permit(:content, :post_id, :user_id)
  end
end
