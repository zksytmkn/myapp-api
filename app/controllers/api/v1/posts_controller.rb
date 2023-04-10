class Api::V1::PostsController < ApplicationController
  before_action :authenticate_active_user
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    posts = Post.all
    render json: posts, methods: [:image_url], include: [:user]
  end

  def create
    post = Post.create!(post_params)
  end

  def show
    render json: @post, methods: [:image_url], include: [:user]
  end

  def update
    @post.update(post_params)
  end

  def destroy
    @post.destroy!
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.permit(:title, :user_id, :body, :image)
  end
end