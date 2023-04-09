class Product < ApplicationRecord
  include Rails.application.routes.url_helpers

  with_options presence: true do
    validates :name
    validates :user_id
    validates :category
    validates :prefecture
    validates :price
    validates :quantity
    validates :stock
    validates :description
  end

  belongs_to :user
  has_one_attached :image
  has_many :product_comments, dependent: :destroy
  has_many :product_favorites, dependent: :destroy
  has_many :product_unfavorites, dependent: :destroy
  has_many :carts, dependent: :destroy
  self.inheritance_column = :_type_disabled

  def image_url
    # 紐づいている画像のURLを取得する
    image.attached? ? url_for(image) : nil
  end
end
