class Api::V1::PostUnfavoritesController < ApplicationController
  before_action :set_post_unfavorite, only: [:destroy]

  def index
    unfavorite_ids = PostUnfavorite.where(user_id: current_user.id).pluck(:post_id)
    post_unfavorites = Post.find(unfavorite_ids)
    render json: post_unfavorites
  end

  def create
    post_unfavorite_params_with_current_user = post_unfavorite_params.merge(user_id: current_user.id)
    post_unfavorite = PostUnfavorite.create!(post_unfavorite_params_with_current_user)
    post_favorite = PostFavorite.find_by(post_unfavorite_params_with_current_user)
    post_favorite&.destroy!
    render json: post_unfavorite, status: :created
  end

  def destroy
    @post_unfavorite.destroy!
    head :no_content
  end

  private

  def post_unfavorite_params
    params.permit(:post_id).merge(user_id: current_user.id)
  end

  def set_post_unfavorite
    @post_unfavorite = PostUnfavorite.find_by!(post_id: params[:post_id], user_id: current_user.id)
  end
end