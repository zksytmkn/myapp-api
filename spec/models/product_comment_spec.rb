require 'rails_helper'

RSpec.describe ProductComment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:product_id) }
    it { should validate_length_of(:content).is_at_most(200).allow_blank }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:product) }
  end
end
