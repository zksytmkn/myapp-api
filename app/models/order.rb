class Order < ApplicationRecord
  with_options presence: true do
    validates :user_id, presence: true
    validates :billing_amount, presence: true
    validates :zipcode, presence: true
    validates :street, presence: true
    validates :building, presence: true
  end

  belongs_to :user
  has_many :order_details, dependent: :destroy
end
