class Relationship < ApplicationRecord

  with_options presence: true do
    validates :following_id
    validates :followed_id
  end

  belongs_to :following, class_name: 'User', :foreign_key => 'following_id'
  belongs_to :followed, class_name: 'User', :foreign_key => 'followed_id'
end
