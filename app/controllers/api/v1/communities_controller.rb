class Api::V1::CommunitiesController < ApplicationController
  before_action :authenticate_active_user

  def index
    communities = Community.all
    render json: communities, methods: [:image_url]
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
    community = Community.find(params[:id])
    community.destroy!
  end

  def community_params
    params.permit(:name, :maker, :text, :image )
  end
end