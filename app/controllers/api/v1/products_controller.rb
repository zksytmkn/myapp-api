class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_active_user

  def index
    products = []
    date = Date.new(2022,12,20)
    10.times do |n|
      id = n + 1
      name = "product #{id.to_s.rjust(2, "0")}"
      text = "サンプルです。紹介文を入れます。"
      price = "¥ #{n * 100}"
      updated_at = date + (id * 6).hours
      products << { id: id, name: name, text: text, price: price, updatedAt: updated_at }
    end
    # 本来はcurrent_user.products
    render json: products
  end
end
