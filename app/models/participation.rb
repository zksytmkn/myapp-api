class Participation < ApplicationRecord
  with_options presence: true do
    validates :user_id, presence: true
    validates :community_id, presence: true
  end

  belongs_to :user
  belongs_to :community
end
