class OrderMessage < ApplicationRecord
  with_options presence: true do
    validates :order_id
    validates :seller_id
    validates :buyer_id
    validates :content
  end

  belongs_to :order
  belongs_to :sender, class_name: 'User', foreign_key: 'seller_id'
  belongs_to :recipient, class_name: 'User', foreign_key: 'buyer_id'
end
