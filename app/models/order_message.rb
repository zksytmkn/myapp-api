class OrderMessage < ApplicationRecord
  with_options presence: true do
    validates :content, presence: true, length: { maximum: 200, allow_blank: true }
    validates :user_id, presence: true
    validates :order_id, presence: true
  end

  belongs_to :user
  belongs_to :order
end
