FactoryBot.define do
  factory :cart do
    user
    product
    quantity { 1 }
  end
end
