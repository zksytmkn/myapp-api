class PostUnfavorite < ApplicationRecord
  with_options presence: true do
    validates :user_id, presence: true
    validates :post_id, presence: true
  end

  belongs_to :user
  belongs_to :post
end
