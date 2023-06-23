FactoryBot.define do
  factory :product_comment do
    content { "This is a product comment" }
    user
    product
  end
end
