FactoryBot.define do
  factory :community_message do
    content { 'Test message' }
    user
    community
  end
end
