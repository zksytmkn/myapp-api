class Api::V1::PostFavoritesController < ApplicationController
  before_action :set_post_favorite, only: [:destroy]

  def index
    post_favorites = PostFavorite.all
    render json: post_favorites
  end

  def create
    post_favorite = PostFavorite.create!(post_favorite_params)
    post_unfavorite = PostUnfavorite.find_by(post_favorite_params)
    post_unfavorite&.destroy!
  end

  def show
    favorite_ids = PostFavorite.where(user_id: params[:id]).pluck(:post_id)
    post_favorites = Post.find(favorite_ids)
    render json: post_favorites
  end

  def destroy
    @post_favorite.destroy!
    head :no_content
  end

  private

  def post_favorite_params
    params.permit(:post_id, :user_id)
  end

  def set_post_favorite
    @post_favorite = PostFavorite.find_by!(post_id: params[:post_id], user_id: params[:user_id])
  end
end
