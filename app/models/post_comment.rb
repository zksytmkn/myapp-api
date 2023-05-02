class PostComment < ApplicationRecord
  with_options presence: true do
    validates :content
    validates :post_id
    validates :user_id
  end

  belongs_to :user
  belongs_to :post
end
