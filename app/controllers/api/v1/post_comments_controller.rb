class Api::V1::PostCommentsController < ApplicationController
  before_action :set_post_comment, only: [:destroy]

  def show
    post_comments = PostComment.where(post_id: params[:id])
    render json: post_comments, include: [:user]
  end

  def create
    post_comment = PostComment.create!(post_comment_params)
  end

  def destroy
    @post_comment.destroy!
  end

  private

  def set_post_comment
    @post_comment = PostComment.find(params[:id])
  end

  def post_comment_params
    params.permit(:postComment_content, :post_id, :user_id)
  end
end
