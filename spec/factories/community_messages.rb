FactoryBot.define do
  factory :community_message do
    content { 'メッセージ' }
    user
    community
  end
end
