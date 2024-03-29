FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    prefecture { "東京都" }
    zipcode { "100-0001" }
    street { "北区" }
    building { "北区アパート101" }
    profile_text { "プロフィール文" }
    confirmation_status { "confirmed" }
    password { "P@ssw0rd" }
  end
end
