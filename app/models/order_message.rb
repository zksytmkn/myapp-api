class OrderMessage < ApplicationRecord
  with_options presence: true do
    validates :content
    validates :user_id
    validates :order_id
  end

  belongs_to :user
  belongs_to :order
end
