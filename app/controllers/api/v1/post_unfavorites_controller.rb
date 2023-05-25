class Api::V1::PostUnfavoritesController < ApplicationController
  before_action :set_post_unfavorite, only: [:destroy]

  def index
    unfavorite_ids = PostUnfavorite.where(user_id: current_user.id).pluck(:post_id)
    post_unfavorites = Post.find(unfavorite_ids)
    render json: post_unfavorites
  end

  def create
    post_unfavorite_params_with_current_user = post_unfavorite_params.merge(user_id: current_user.id)
    post_unfavorite = PostUnfavorite.new(post_unfavorite_params_with_current_user)
    if post_unfavorite.save
      post_favorite = PostFavorite.find_by(post_unfavorite_params_with_current_user)
      post_favorite&.destroy!
      render json: post_unfavorite, status: :created
    else
      render json: { error: 'ないねできませんでした' }, status: :unprocessable_entity
    end
  end

  def destroy
    if @post_unfavorite.destroy
      head :no_content
    else
      render json: { error: 'ないねを解除できませんでした' }, status: :unprocessable_entity
    end
  end

  private

  def post_unfavorite_params
    params.require(:post_unfavorite).permit(:post_id)
  end

  def set_post_unfavorite
    @post_unfavorite = PostUnfavorite.find_by(post_id: params[:id], user_id: current_user.id)
    if @post_unfavorite.nil?
      render json: { error: 'ないねが見つかりません' }, status: :not_found
    end
  end
end
