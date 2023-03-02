class Api::V1::PostsController < ApplicationController
  before_action :authenticate_active_user

  def index
    posts = Post.all
    render json: posts, methods: [:image_url], include: [:user]
  end

  def new
    post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.save!
  end

  def show
    post = Post.find(params[:id])
    render json: post, methods: [:image_url], include: [:user]
  end

  def edit
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy!
  end

  def post_params
    params.permit(:name, :user_id, :text, :image )
  end
end