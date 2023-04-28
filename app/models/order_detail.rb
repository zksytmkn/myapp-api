class OrderDetail < ApplicationRecord
  with_options presence: true do
    validates :order_id
    validates :product_id
    validates :price
    validates :quantity
    validates :status
  end

  belongs_to :order
  belongs_to :product

  enum status: {
    confirm_payment: 0,
    shipped: 1,
    out_for_delivery: 2,
    delivered: 3
  }
end
