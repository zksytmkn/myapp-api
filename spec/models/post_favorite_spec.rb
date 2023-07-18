require 'rails_helper'

RSpec.describe PostFavorite, type: :model do
  describe 'validations' do
    subject { create(:post_favorite) }

    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:post_id) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:post_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
