class Api::V1::PostFavoritesController < ApplicationController

  def create
    postFavorite = PostFavorite.new(postFavorite_params)
    postFavorite.save!
  end

  def postFavorite_params
    params.permit(:post_id, :user_id)
  end
end
