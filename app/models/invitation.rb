class Invitation < ApplicationRecord
  with_options presence: true do
    validates :inviting_id, presence: true
    validates :invited_id, presence: true
    validates :community_id, presence: true
  end

  belongs_to :inviting, class_name: 'User', :foreign_key => 'inviting_id'
  belongs_to :invited, class_name: 'User', :foreign_key => 'invited_id'
  belongs_to :community
end
