class Api::V1::CommunitiesController < ApplicationController
  before_action :authenticate_active_user

  def index
    communities = []
    date = Date.new(2022,12,20)
    10.times do |n|
      id = n + 1
      name = "コミュニティ #{id.to_s.rjust(2, "0")}"
      text = "サンプルです。紹介文を入れます。"
      updated_at = date + (id * 6).hours
      participated = false
      invited = false
      maker = "作成者 #{id.to_s.rjust(2, "0")}"
      type = "果物"
      region = "東北地方"
      prefecture = "青森県"
      member = n + 1
      communities << { id: id, name: name, text: text, updatedAt: updated_at, participated: participated, invited: invited, maker: maker, type: type, region: region, prefecture: prefecture, member: member }
    end
    # 本来はcurrent_user.communities
    render json: communities
  end
end
