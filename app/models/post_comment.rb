class PostComment < ApplicationRecord
  with_options presence: true do
    validates :content, length: { maximum: 200, allow_blank: true }
    validates :user_id
    validates :post_id
  end

  belongs_to :user
  belongs_to :post
end
