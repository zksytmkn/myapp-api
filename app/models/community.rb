class Community < ApplicationRecord
  include Rails.application.routes.url_helpers

  with_options presence: true do
    validates :name, length: { maximum: 13, allow_blank: true }
    validates :description, length: { maximum: 300, allow_blank: true }
    validates :user_id
  end

  belongs_to :user
  has_one_attached :image
  has_many :community_messages, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :invitations, dependent: :destroy
  self.inheritance_column = :_type_disabled

  def image_url
    # 紐づいている画像のURLを取得する
    image.attached? ? url_for(image) : nil
  end
end
