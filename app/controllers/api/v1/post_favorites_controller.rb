class Api::V1::PostFavoritesController < ApplicationController

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
    postFavorite = PostFavorite.find_by(postFavorite_params)
    postFavorite.destroy!
  end

  def postFavorite_params
    params.permit(:post_id, :user_id)
  end
end
