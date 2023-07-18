require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    subject { create(:post) }

    it { should validate_presence_of(:user_id) }
    it { should validate_length_of(:title).is_at_most(30) }
    it { should validate_length_of(:body).is_at_most(400) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:post_comments).dependent(:destroy) }
    it { should have_many(:post_favorites).dependent(:destroy) }
    it { should have_many(:post_unfavorites).dependent(:destroy) }
  end
end
