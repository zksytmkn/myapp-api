require 'rails_helper'

RSpec.describe CommunityMessage, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:community_id) }
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_most(200) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:community) }
  end
end
