class Api::V1::PostFavoritesController < ApplicationController
  before_action :set_post_favorite, only: [:destroy]

  def index
    favorite_ids = PostFavorite.where(user_id: current_user.id).pluck(:post_id)
    post_favorites = Post.find(favorite_ids)
    render json: post_favorites
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
    params.permit(:post_id).merge(user_id: current_user.id)
  end

  def set_post_favorite
    @post_favorite = PostFavorite.find_by!(post_id: params[:post_id], user_id: current_user.id)
  end
end
