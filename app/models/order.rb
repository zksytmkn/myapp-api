class Order < ApplicationRecord

  with_options presence: true do
    validates :user_id
    validates :billing_amount
    validates :zipcode
    validates :street
    validates :building
  end

  belongs_to :user
end
