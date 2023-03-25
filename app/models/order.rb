class Order < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :billing_amount
  end

  belongs_to :user
end
