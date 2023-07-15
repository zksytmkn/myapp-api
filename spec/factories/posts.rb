FactoryBot.define do
  factory :post do
    title { "つぶやき" }
    body { "つぶやきです。" }
    user
  end
end
