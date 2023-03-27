class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag
  belongs_to :user
  validates :post_id, presence: true
  validates :tag_id, presence: true
  validates :user_id, presence: true
end
