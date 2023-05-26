class Cart < ApplicationRecord
  with_options presence: true do
    validates :product_id
    validates :user_id
    validates :quantity
  end

  validates_uniqueness_of :user_id, scope: :product_id

  belongs_to :user
  belongs_to :product
end
