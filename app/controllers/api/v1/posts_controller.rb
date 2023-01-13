class Api::V1::PostsController < ApplicationController
  before_action :authenticate_active_user

  def index
    posts = []
    date = Date.new(2022,12,20)
    10.times do |n|
      id = n + 1
      name = "農家の呟き #{id.to_s.rjust(2, "0")}"
      poster = "投稿者 #{id.to_s.rjust(2, "0")}"
      text="サンプルです。紹介文を入れます。aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
      updated_at = date + (id * 6).hours
      like = false
      dislike = false
      posts << { id: id, name: name, poster: poster, text: text, updatedAt: updated_at, like: like, dislike: dislike }
    end
    # 本来はcurrent_user.posts
    render json: posts
  end
end
