class Api::V1::RelationshipsController < ApplicationController

  def create
    relationship_params_with_current_user = relationship_params.merge(following_id: current_user.id)
    Relationship.create!(relationship_params_with_current_user)
  end

  def user_follow_relationships
    following_ids = Relationship.where(following_id: params[:id]).pluck(:followed_id)
    followed_ids = Relationship.where(followed_id: params[:id]).pluck(:following_id)

    following_users = User.find(following_ids)
    followed_users = User.find(followed_ids)

    render json: { following: following_users, followers: followed_users }
  end

  def destroy
    relationship = Relationship.find_by(relationship_params.merge(following_id: current_user.id))
    relationship.destroy!
  end

  private

  def relationship_params
    params.require(:relationship).permit(:followed_id)
  end
end
