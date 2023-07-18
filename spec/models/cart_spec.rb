require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'validations' do
    subject { create(:cart) }

    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:product_id) }
    it { should validate_presence_of(:quantity) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:product_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:product) }
  end
end
