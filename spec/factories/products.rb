FactoryBot.define do
  factory :product do
    name { "Product Name" }
    category { "Product Category" }
    prefecture { "Product Prefecture" }
    price { 100 }
    stock { 10 }
    description { "Product Description" }
    user
  end
end
