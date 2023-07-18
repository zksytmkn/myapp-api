require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
  describe 'validations' do
    subject { create(:order_detail) }

    it { should validate_presence_of(:order_id) }
    it { should validate_presence_of(:product_id) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:status) }
    it { should validate_uniqueness_of(:order_id).scoped_to(:product_id) }
  end

  describe 'associations' do
    it { should belong_to(:order) }
    it { should belong_to(:product) }
  end
end
