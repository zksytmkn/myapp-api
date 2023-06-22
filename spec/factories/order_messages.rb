FactoryBot.define do
  factory :order_message do
    content { Faker::Lorem.sentence(word_count: 5) }
    user
    order
  end
end
