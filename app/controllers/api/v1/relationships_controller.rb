class Api::V1::RelationshipsController < ApplicationController
  def create
    relationship_params_with_current_user = relationship_params.merge(following_id: current_user.id)
    begin
      Relationship.create!(relationship_params_with_current_user)
      render json: {}, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.record.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def destroy
    relationship = Relationship.find_by(relationship_params.merge(following_id: current_user.id))
    if relationship.nil?
      render json: { error: 'フォロー情報が見つかりません' }, status: :not_found
      return
    end
    begin
      relationship.destroy!
      render json: {}, status: :no_content
    rescue ActiveRecord::RecordNotDestroyed => e
      render json: { error: 'フォローを解除できませんでした' }, status: :unprocessable_entity
    end
  end

  def user_follow_relationships
    following_ids = Relationship.where(following_id: params[:id]).pluck(:followed_id)
    followed_ids = Relationship.where(followed_id: params[:id]).pluck(:following_id)

    following_users = User.find(following_ids)
    followed_users = User.find(followed_ids)

    render json: { following: following_users, followers: followed_users }
  end

  private

  def relationship_params
    params.require(:relationship).permit(:followed_id)
  end
end
