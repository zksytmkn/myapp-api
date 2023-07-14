FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    prefecture { "東京都" }
    zipcode { "1000001" }
    street { "北区" }
    building { "北区アパート101" }
    profile_text { "プロフィール文" }
    password { "Passw0rd!" }
  end
end
