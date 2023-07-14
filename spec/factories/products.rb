FactoryBot.define do
  factory :product do
    name { "農産物" }
    category { "野菜" }
    prefecture { "東京都" }
    price { 100 }
    stock { 10 }
    description { "説明文" }
    user
  end
end
