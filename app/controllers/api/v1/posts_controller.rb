class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    posts = Post.all
    posts_with_favorites = posts.map do |post|
      {
        post: post.as_json(methods: [:image_url], include: { user: { only: :name } }),
        favorites_count: post.favorites_count,
        unfavorites_count: post.unfavorites_count
      }
    end
    render json: posts_with_favorites
  end

  def show
    render json: {
      post: @post.as_json(
        methods: [:image_url],
        include: { user: { only: :name } }
      ),
      favorites_count: @post.favorites_count,
      unfavorites_count: @post.unfavorites_count
    }
  end

  def create
    post_params_with_current_user = post_params.merge(user_id: current_user.id)
    post = Post.new(post_params_with_current_user)
    if post.save
      render json: post, status: :created
    else
      render json: { error: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: { error: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      head :no_content
    else
      render json: { error: 'つぶやきを削除できませんでした' }, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
    return if @post

    render json: { error: 'つぶやきが見つかりません' }, status: :not_found
  end

  def post_params
    params.permit(:title, :body, :image)
  end
end
