require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(10) }
    it { should validate_uniqueness_of(:name).case_insensitive }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(8) }
    it { should allow_value('Password1!', 'Passw0rd$').for(:password) }
    it { should_not allow_value('password', 'PASSWORD', '12345678', '!@#$%^&*').for(:password) }
  end

  describe 'associations' do
    it { should have_many(:products).dependent(:destroy) }
    it { should have_many(:product_comments).dependent(:destroy) }
    it { should have_many(:product_favorites).dependent(:destroy) }
    it { should have_many(:product_unfavorites).dependent(:destroy) }
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:post_comments).dependent(:destroy) }
    it { should have_many(:post_favorites).dependent(:destroy) }
    it { should have_many(:post_unfavorites).dependent(:destroy) }
    it { should have_many(:communities).dependent(:destroy) }
    it { should have_many(:community_messages).dependent(:destroy) }
    it { should have_many(:participations).dependent(:destroy) }
    it { should have_many(:inviting_invitations).class_name('Invitation').with_foreign_key('inviting_id') }
    it { should have_many(:invited_invitations).class_name('Invitation').with_foreign_key('invited_id') }
    it { should have_many(:following_relationships).class_name('Relationship').with_foreign_key('following_id') }
    it { should have_many(:followed_relationships).class_name('Relationship').with_foreign_key('followed_id') }
    it { should have_many(:carts).dependent(:destroy) }
    it { should have_many(:orders).dependent(:destroy) }
    it { should have_many(:order_details).dependent(:destroy) }
  end
end
