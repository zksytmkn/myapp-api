class Api::V1::PostUnfavoritesController < ApplicationController

  def index
    post_unfavorites = PostUnfavorite.all
    render json: post_unfavorites
  end

  def create
    post_unfavorite = PostUnfavorite.create!(post_unfavorite_params)
    post_favorite = PostFavorite.find_by(post_unfavorite_params)
    post_favorite&.destroy!
  end

  def show
    unfavorite_ids = PostUnfavorite.where(user_id: params[:id]).pluck(:post_id)
    post_unfavorites = Post.find(unfavorite_ids)
    render json: post_unfavorites
  end

  def destroy
    post_unfavorite = PostUnfavorite.find_by(post_unfavorite_params)
    post_unfavorite.destroy!
  end

  private

  def post_unfavorite_params
    params.permit(:post_id, :user_id)
  end
end
