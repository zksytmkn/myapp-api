class Cart < ApplicationRecord
  with_options presence: true do
    validates :product_id
    validates :user_id
    validates :quantity
  end

  belongs_to :user
  belongs_to :product
end
