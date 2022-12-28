class Api::V1::PostsController < ApplicationController
  before_action :authenticate_active_user

  def index
    posts = []
    date = Date.new(2022,12,20)
    10.times do |n|
      id = n + 1
      name = "#{current_user.name} post #{id.to_s.rjust(2, "0")}"
      updated_at = date + (id * 6).hours
      posts << { id: id, name: name, updatedAt: updated_at }
    end
    # 本来はcurrent_user.posts
    render json: posts
  end
end
