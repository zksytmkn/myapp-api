class Product < ApplicationRecord
  include Rails.application.routes.url_helpers

  with_options presence: true do
    validates :name, length: { maximum: 10, allow_blank: true }
    validates :user_id
    validates :category
    validates :prefecture
    validates :price
    validates :stock
    validates :description, length: { maximum: 300, allow_blank: true }
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

  def favorites_count
    ProductFavorite.where(product_id: id).count
  end

  def unfavorites_count
    ProductUnfavorite.where(product_id: id).count
  end
end
