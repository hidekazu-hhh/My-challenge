class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :post_tags
  has_many :users, through: :post_tags

  validates :name, uniqueness:{ case_sensitive: true }, presence: true
  # ログの警告対策
end
