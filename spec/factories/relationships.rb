FactoryBot.define do
  factory :relationship do
    following { create(:user) }
    followed { create(:user) }
  end
end
