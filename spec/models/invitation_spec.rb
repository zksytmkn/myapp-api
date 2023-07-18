require 'rails_helper'

RSpec.describe Invitation, type: :model do
  describe 'validations' do
    subject { create(:invitation) }

    it { should validate_presence_of(:inviting_id) }
    it { should validate_presence_of(:invited_id) }
    it { should validate_presence_of(:community_id) }
    it { should validate_uniqueness_of(:invited_id).scoped_to(:community_id) }
  end

  describe 'associations' do
    it { should belong_to(:inviting) }
    it { should belong_to(:invited) }
    it { should belong_to(:community) }
  end
end
