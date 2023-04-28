class Participation < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :community_id
  end

  belongs_to :user
  belongs_to :community
end
