class Api::V1::PostFavoritesController < ApplicationController
  before_action :set_post_favorite, only: [:destroy]

  def index
    postFavorites = PostFavorite.all
    render json: postFavorites
  end

  def create
    postFavorite = PostFavorite.new(postFavorite_params)
    postFavorite.save!
    if  postUnfavorite = PostUnfavorite.find_by(postFavorite_params)
        postUnfavorite.destroy!
    end
  end

  def show
    favorite = PostFavorite.where(user_id: params[:id]).pluck(:post_id)
    postFavorite = Post.find(favorite)
    render json: postFavorite
  end

  def destroy
    @post_favorite.destroy!
    head :no_content
  end

  private

  def postFavorite_params
    params.permit(:post_id, :user_id)
  end

  def set_post_favorite
    @post_favorite = PostFavorite.find_by!(post_id: params[:post_id], user_id: params[:user_id])
  end
end
