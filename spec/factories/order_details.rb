FactoryBot.define do
  factory :order_detail do
    order
    product
    price { Faker::Number.decimal(l_digits: 2) }
    quantity { Faker::Number.between(from: 1, to: 10) }
    status { OrderDetail.statuses.keys.sample }
  end
end
