class Participation < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :community_id
  end

  validates_uniqueness_of :user_id, scope: :community_id

  belongs_to :user
  belongs_to :community
end
