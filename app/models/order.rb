class Order < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :billing_amount
    validates :status
  end

  belongs_to :user

  enum status: {
    confirm_payment: 0,
    shipped: 1,
    out_for_delivery: 2,
    delivered: 3
  }
end
