class Api::V1::PostUnfavoritesController < ApplicationController

  def create
    postUnfavorite = PostUnfavorite.new(postUnfavorite_params)
    postUnfavorite.save!
  end

  def postUnfavorite_params
    params.permit(:post_id, :user_id)
  end
end
