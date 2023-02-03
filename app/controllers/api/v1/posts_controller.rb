class Api::V1::PostsController < ApplicationController
  before_action :authenticate_active_user
  before_action :set_post, only: [:show, :edit, :update, :delete]

  def index
    posts = Post.all
    render json: posts, methods: [:image_url]
  end

  def new
    post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.save!
  end

  def show
  end

  def edit
  end

  def update
    if post.update(post_params)
      flash[:success] = "呟きを編集しました"
      redirect_to()
    else
      flash[:failure] = "呟きの編集に失敗しました"
      render :edit
    end
  end

  def destroy
    if post.destroy
      flash[:success] = "呟きを削除しました"
      redirect_to()
    else
      flash[:failure] = "呟きの削除に失敗しました"
      render :show
    end
  end

  def set_post
    post = Post.find(params[:id])
  end

  def post_params
    params.permit(:name, :poster, :text, :image )
  end
end