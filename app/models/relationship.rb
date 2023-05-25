class Relationship < ApplicationRecord
  with_options presence: true do
    validates :following_id, presence: true
    validates :followed_id, presence: true
  end

  validates_uniqueness_of :following_id, scope: :followed_id

  belongs_to :following, class_name: 'User', :foreign_key => 'following_id'
  belongs_to :followed, class_name: 'User', :foreign_key => 'followed_id'
end
