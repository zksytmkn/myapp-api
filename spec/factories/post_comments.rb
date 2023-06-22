FactoryBot.define do
  factory :post_comment do
    content { "Test Comment Content" }
    user
    post
  end
end
