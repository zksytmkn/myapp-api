class Product < ApplicationRecord
  include Rails.application.routes.url_helpers

  with_options presence: true do
    validates :name
    validates :user_id
    validates :type
    validates :prefecture
    validates :price
    validates :quantity
    validates :inventory
    validates :text
  end
  belongs_to :user
  has_one_attached :image
  has_many :productComments
  self.inheritance_column = :_type_disabled

  def image_url
    # 紐づいている画像のURLを取得する
    image.attached? ? url_for(image) : nil
  end
end
