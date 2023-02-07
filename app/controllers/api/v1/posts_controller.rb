class Api::V1::PostsController < ApplicationController
  before_action :authenticate_active_user

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
    post = Post.find(params[:id])
    post.update(post_params)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy!
  end

  def post_params
    params.permit(:name, :poster, :text, :image )
  end
end