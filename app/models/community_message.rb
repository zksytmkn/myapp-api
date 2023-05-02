class CommunityMessage < ApplicationRecord
  with_options presence: true do
    validates :content
    validates :community_id
    validates :user_id
  end

  belongs_to :user
  belongs_to :community
end
