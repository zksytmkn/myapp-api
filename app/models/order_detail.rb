class OrderDetail < ApplicationRecord
  with_options presence: true do
    validates :order_id
    validates :product_id
    validates :price
    validates :quantity
  end

  belongs_to :order
  belongs_to :product
end
