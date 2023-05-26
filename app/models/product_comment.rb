class ProductComment < ApplicationRecord
  with_options presence: true do
    validates :content, length: { maximum: 200, allow_blank: true }
    validates :product_id
    validates :user_id
  end

  belongs_to :user
  belongs_to :product
end
