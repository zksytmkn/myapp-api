class Api::V1::PostCommentsController < ApplicationController

  def index
    postComments = PostComment.all
    render json: postComments
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
