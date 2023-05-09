class Api::V1::PostsController < ApplicationController
  before_action :authenticate_active_user
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    posts = Post.all
    posts_with_favorites = posts.map do |post|
      {
        post: post,
        favorites_count: PostFavorite.where(post_id: post.id).count,
        unfavorites_count: PostUnfavorite.where(post_id: post.id).count
      }
    end
    render json: posts_with_favorites
  end

  def create
    post_params_with_user = post_params.merge(user_id: current_user.id)
    post = Post.create!(post_params_with_user)
    render json: post, status: :created
  end

  def show
    favorites_count = PostFavorite.where(post_id: @post.id).count
    unfavorites_count = PostUnfavorite.where(post_id: @post.id).count
    render json: {
      post: @post.as_json(methods: [:image_url], include: [:user]),
      favorites_count: favorites_count,
      unfavorites_count: unfavorites_count
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
