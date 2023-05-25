class Api::V1::PostCommentsController < ApplicationController
  before_action :set_post, only: [:index, :create]
  before_action :set_post_comment, only: [:destroy]

  def index
    post_comments = @post.post_comments.as_json(include: { user: { only: :name, methods: :image_url } })
    render json: post_comments
  end

  def create
    post_comment = @post.post_comments.new(post_comment_params)
    if post_comment.save
      render json: post_comment, status: :created
    else
      render json: { error: 'コメントできませんでした' }, status: :unprocessable_entity
    end
  end

  def destroy
    if @post_comment.destroy
      head :no_content
    else
      render json: { error: 'コメントを削除できませんでした' }, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:post_id])
    return if @post

    render json: { error: 'つぶやきが見つかりません' }, status: :not_found
  end

  def set_post_comment
    @post_comment = PostComment.find_by(id: params[:id])
    return if @post_comment

    render json: { error: 'コメントが見つかりません' }, status: :not_found
  end

  def post_comment_params
    params.require(:post_comment).permit(:content).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
