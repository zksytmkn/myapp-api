class OrderDetail < ApplicationRecord
  with_options presence: true do
    validates :order_id, presence: true
    validates :product_id, presence: true
    validates :price, presence: true
    validates :quantity, presence: true
    validates :status, presence: true
  end

  validates_uniqueness_of :order_id, scope: :product_id

  belongs_to :order
  belongs_to :product

  enum status: {
    confirm_payment: 0,
    shipped: 1,
    out_for_delivery: 2,
    delivered: 3
  }
end
