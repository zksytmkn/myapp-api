class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    posts = Post.all
    posts_with_favorites = posts.map do |post|
      {
        post: post.as_json(methods: [:image_url]),
        favorites_count: post.favorites_count,
        unfavorites_count: post.unfavorites_count
      }
    end
    render json: posts_with_favorites
  end

  def create
    post_params_with_current_user = post_params.merge(user_id: current_user.id)
    post = Post.create!(post_params_with_current_user)
    render json: post, status: :created
  end

  def show
    render json: {
      post: @post.as_json(methods: [:image_url], include: [:user]),
      favorites_count: @post.favorites_count,
      unfavorites_count: @post.unfavorites_count
    }
  end

  def update
    @post.update!(post_params)
    render json: @post
  end

  def destroy
    @post.destroy!
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.permit(:title, :body, :image)
  end
end
