class Invitation < ApplicationRecord
  belongs_to :inviting, class_name: 'User', :foreign_key => 'inviting_id'
  belongs_to :invited, class_name: 'User', :foreign_key => 'invited_id'
  belongs_to :community
end
