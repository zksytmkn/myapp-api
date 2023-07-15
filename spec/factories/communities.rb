FactoryBot.define do
  factory :community do
    user
    name { 'コミュニティ' }
    description { '説明文です。' }
  end
end
