class ProductComment < ApplicationRecord
  with_options presence: true do
    validates :content, presence: true, length: { maximum: 200, allow_blank: true }
    validates :product_id, presence: true
    validates :user_id, presence: true
  end

  belongs_to :user
  belongs_to :product
end
