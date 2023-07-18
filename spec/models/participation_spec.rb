require 'rails_helper'

RSpec.describe Participation, type: :model do
  describe 'validations' do
    subject { create(:participation) }

    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:community_id) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:community_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:community) }
  end
end
