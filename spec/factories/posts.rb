FactoryBot.define do
  factory :post do
    title { "MyPostTitle" }
    body { "This is the body of my post" }
    user
  end
end
