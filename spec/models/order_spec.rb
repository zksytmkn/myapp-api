require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:billing_amount) }
    it { should validate_presence_of(:zipcode) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:building) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:order_details) }
  end
end
