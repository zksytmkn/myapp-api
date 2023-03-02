class Post < ApplicationRecord
  include Rails.application.routes.url_helpers

  with_options presence: true do
    validates :name
    validates :user_id
    validates :text
  end
  belongs_to :user
  has_one_attached :image
  has_many :postComments, dependent: :destroy
  has_many :postFavorites, dependent: :destroy
  has_many :postUnfavorites, dependent: :destroy
  self.inheritance_column = :_type_disabled

  def image_url
    # 紐づいている画像のURLを取得する
    image.attached? ? url_for(image) : nil
  end
end
