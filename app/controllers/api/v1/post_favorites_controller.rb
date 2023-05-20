class Api::V1::PostFavoritesController < ApplicationController
  before_action :set_post_favorite, only: [:destroy]

  def index
    favorite_ids = PostFavorite.where(user_id: current_user.id).pluck(:post_id)
    post_favorites = Post.find(favorite_ids)

    post_favorites_with_counts = post_favorites.map do |post|
      {
        post: post,
        favorites_count: post.favorites_count,
        unfavorites_count: post.unfavorites_count
      }
    end

    render json: post_favorites_with_counts
  end

  def create
    post_favorite_params_with_current_user = post_favorite_params.merge(user_id: current_user.id)
    post_favorite = PostFavorite.create!(post_favorite_params_with_current_user)
    post_unfavorite = PostUnfavorite.find_by(post_favorite_params_with_current_user)
    post_unfavorite&.destroy!
    render json: post_favorite, status: :created
  end

  def destroy
    @post_favorite.destroy!
    head :no_content
  end

  private

  def post_favorite_params
    params.require(:post_favorite).permit(:post_id)
  end

  def set_post_favorite
    @post_favorite = PostFavorite.find_by!(post_id: params[:id], user_id: current_user.id)
  end
end
