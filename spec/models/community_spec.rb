require 'rails_helper'

RSpec.describe Community, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(10) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_most(300) }
    it { should validate_presence_of(:user_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:community_messages).dependent(:destroy) }
    it { should have_many(:participations).dependent(:destroy) }
    it { should have_many(:invitations).dependent(:destroy) }
  end
end
