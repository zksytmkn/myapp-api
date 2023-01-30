class Api::V1::CommunitiesController < ApplicationController
  before_action :authenticate_active_user
  before_action :set_community, only: [:show, :edit, :update, :delete]

  def index
    communities = Community.all
    render json: communities
  end

  def new
    community = Community.new
  end

  def create
    community = Community.new(community_params)
    community.save!
  end

  def show
  end

  def edit
  end

  def update
    if community.update(community_params)
      flash[:success] = "コミュニティを編集しました"
      redirect_to()
    else
      flash[:failure] = "コミュニティの編集に失敗しました"
      render :edit
    end
  end

  def destroy
    if community.destroy
      flash[:success] = "コミュニティを削除しました"
      redirect_to()
    else
      flash[:failure] = "コミュニティの削除に失敗しました"
      render :show
    end
  end

  def set_community
    community = Community.find(params[:id])
  end

  def community_params
    params.require(:community).permit(:name, :maker, :text )
  end
end