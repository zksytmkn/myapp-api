FactoryBot.define do
  factory :invitation do
    inviting { create(:user) }
    invited { create(:user) }
    community { create(:community) }
  end
end