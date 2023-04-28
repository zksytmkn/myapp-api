class PostUnfavorite < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :post_id
  end

  belongs_to :user
  belongs_to :post
end
