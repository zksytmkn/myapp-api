FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    prefecture { "Tokyo" }
    zipcode { "1000001" }
    street { "Chiyoda" }
    building { "Tokyo Station" }
    profile_text { "Hello, World!" }
    password { "Passw0rd!" }
  end
end
