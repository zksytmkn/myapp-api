class PostUnfavorite < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :post_id
  end

  validates_uniqueness_of :user_id, scope: :post_id

  belongs_to :user
  belongs_to :post
end
