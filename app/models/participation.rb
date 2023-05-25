class Participation < ApplicationRecord
  with_options presence: true do
    validates :user_id, presence: true
    validates :community_id, presence: true
  end

  validates_uniqueness_of :user_id, scope: :community_id

  belongs_to :user
  belongs_to :community
end
