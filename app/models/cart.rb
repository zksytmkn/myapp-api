class Cart < ApplicationRecord
  with_options presence: true do
    validates :product_id, presence: true
    validates :user_id, presence: true
    validates :quantity, presence: true
  end

  belongs_to :user
  belongs_to :product
end
