class Api::V1::PostCommentsController < ApplicationController

  def show
    postComments = PostComment.where(post_id: params[:id])
    render json: postComments, include: [:user]
  end

  def create
    postComment = PostComment.new(postComment_params)
    postComment.save!
  end

  private
  def postComment_params
    params.require(:postComment).permit(:postComment_content, :post_id)
  end
end
