class Post < ApplicationRecord
  include Rails.application.routes.url_helpers

  with_options presence: true do
    validates :name
    validates :poster
    validates :text
  end
  has_one_attached :image
  self.inheritance_column = :_type_disabled

  def image_url
    # 紐づいている画像のURLを取得する
    image.attached? ? url_for(image) : nil
  end
end
