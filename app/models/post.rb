class Post < ApplicationRecord
  include Rails.application.routes.url_helpers

  with_options presence: true do
    validates :title
    validates :user_id
    validates :body
  end

  belongs_to :user
  has_one_attached :image
  has_many :post_comments, dependent: :destroy
  has_many :post_favorites, dependent: :destroy
  has_many :post_unfavorites, dependent: :destroy
  self.inheritance_column = :_type_disabled

  def image_url
    # 紐づいている画像のURLを取得する
    image.attached? ? url_for(image) : nil
  end
end
