class ProductComment < ApplicationRecord

  with_options presence: true do
    validates :productComment_content
    validates :product_id
    validates :user_id
  end

  belongs_to :user
  belongs_to :product
end
