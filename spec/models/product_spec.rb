require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:prefecture) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:stock) }
    it { should validate_length_of(:name).is_at_most(10) }
    it { should validate_length_of(:description).is_at_most(300) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:product_comments).dependent(:destroy) }
    it { should have_many(:product_favorites).dependent(:destroy) }
    it { should have_many(:product_unfavorites).dependent(:destroy) }
    it { should have_many(:carts).dependent(:destroy) }
  end
