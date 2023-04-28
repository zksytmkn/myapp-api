class Invitation < ApplicationRecord
  with_options presence: true do
    validates :inviting_id
    validates :invited_id
    validates :community_id
  end

  belongs_to :inviting, class_name: 'User', :foreign_key => 'inviting_id'
  belongs_to :invited, class_name: 'User', :foreign_key => 'invited_id'
  belongs_to :community
end
