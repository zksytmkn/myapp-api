class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_active_user

  def index
    products = []
    date = Date.new(2022,12,20)
    10.times do |n|
      id = n + 1
      quantity = 1
      inventory = 20
      name = "農産物 #{id.to_s.rjust(2, "0")}"
      text = "サンプルです。紹介文を入れます。"
      price = n * 100
      updated_at = date + (id * 6).hours
      like = false
      dislike = false
      purchased = false
      seller = "投稿者 #{id.to_s.rjust(2, "0")}"
      type = "果物"
      region = "東北地方"
      prefecture = "青森県"
      recommend = false
      products << { id: id, name: name, text: text, price: price, quantity: quantity, inventory: inventory, updatedAt: updated_at, like: like, dislike: dislike, purchased: purchased, seller: seller, type: type, region: region, prefecture: prefecture , recommend: recommend }
    end
    # 本来はcurrent_user.products
    render json: products
  end
end
