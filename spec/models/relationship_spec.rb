require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:following_id) }
    it { should validate_presence_of(:followed_id) }
    it { should validate_uniqueness_of(:following_id).scoped_to(:followed_id) }
  end

  describe 'associations' do
    it { should belong_to(:following) }
    it { should belong_to(:followed) }
  end
end
