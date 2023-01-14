class Api::V1::CommunitiesController < ApplicationController
  before_action :authenticate_active_user

  def index
    communities = []
    date = Date.new(2022,12,20)
    10.times do |n|
      id = n + 1
      name = "コミュニティ #{id.to_s.rjust(2, "0")}"
      text = "サンプルです。紹介文を入れます。aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
      updated_at = date + (id * 6).hours
      communities << { id: id, name: name, text: text, updatedAt: updated_at }
    end
    # 本来はcurrent_user.communities
    render json: communities
  end
end
