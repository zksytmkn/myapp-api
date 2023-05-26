class Invitation < ApplicationRecord
  with_options presence: true do
    validates :inviting_id
    validates :invited_id
    validates :community_id
  end

  validates_uniqueness_of :invited_id, scope: :community_id

  belongs_to :inviting, class_name: 'User', :foreign_key => 'inviting_id'
  belongs_to :invited, class_name: 'User', :foreign_key => 'invited_id'
  belongs_to :community
end
