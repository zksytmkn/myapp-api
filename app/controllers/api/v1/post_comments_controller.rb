class Api::V1::PostCommentsController < ApplicationController

  def show
    postComments = PostComment.where(post_id: params[:id])
    render json: postComments, include: [:user]
  end

  def create
    postComment = PostComment.new(postComment_params)
    postComment.save!
  end

  def destroy
    postComment = PostComment.find(params[:id])
    postComment.destroy!
  end

  def postComment_params
    params.permit(:postComment_content, :post_id, :user_id)
  end
end
