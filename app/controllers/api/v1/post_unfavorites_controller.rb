class Api::V1::PostUnfavoritesController < ApplicationController

  def index
    postUnfavorites = PostUnfavorite.all
    render json: postUnfavorites
  end

  def create
    postUnfavorite = PostUnfavorite.new(postUnfavorite_params)
    postUnfavorite.save!
    if  postFavorite = PostFavorite.find_by(postUnfavorite_params)
        postFavorite.destroy!
    end
  end

  def show
    unfavorite = PostUnfavorite.where(user_id: params[:id]).pluck(:post_id)
    postUnfavorite = Post.find(unfavorite)
    render json: postUnfavorite
  end

  def destroy
    postUnfavorite = PostUnfavorite.find_by(postUnfavorite_params)
    postUnfavorite.destroy!
  end

  def postUnfavorite_params
    params.permit(:post_id, :user_id)
  end
end
