class PostUnfavorite < ApplicationRecord
  with_options presence: true do
    validates :user_id, presence: true
    validates :post_id, presence: true
  end

  validates_uniqueness_of :user_id, scope: :post_id

  belongs_to :user
  belongs_to :post
end
