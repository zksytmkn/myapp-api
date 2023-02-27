class Api::V1::RelationshipsController < ApplicationController

  def create
    relationship = Relationship.new(relationship_params)
    relationship.save!
  end

  def show
    following = Relationship.where(following_id: params[:id]).pluck(:followed_id)
    followingUser = User.find(following)
    followed = Relationship.where(followed_id: params[:id]).pluck(:following_id)
    followedUser = User.find(followed)
    render json: {following: followingUser, followed: followedUser}
  end

  def destroy
    relationship = Relationship.find_by(relationship_params)
    relationship.destroy!
  end

  def relationship_params
    params.permit(:following_id, :followed_id)
  end
end
