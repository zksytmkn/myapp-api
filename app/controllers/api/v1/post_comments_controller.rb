class Api::V1::PostCommentsController < ApplicationController
  before_action :set_post, only: [:index, :create]
  before_action :set_post_comment, only: [:destroy]

  def index
    post_comments = @post.post_comments
    render json: post_comments, include: [:user]
  end

  def create
    post_comment = @post.post_comments.create!(post_comment_params)
    render json: post_comment, status: :created
  end

  def destroy
    @post_comment.destroy!
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_post_comment
    @post_comment = PostComment.find(params[:id])
  end

  def post_comment_params
    params.require(:post_comment).permit(:content).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
