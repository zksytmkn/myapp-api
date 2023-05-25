class ProductUnfavorite < ApplicationRecord
  with_options presence: true do
    validates :user_id, presence: true
    validates :product_id, presence: true
  end

  validates_uniqueness_of :user_id, scope: :product_id

  belongs_to :user
  belongs_to :product
end
