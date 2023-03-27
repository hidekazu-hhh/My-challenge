class PositiveWord < ApplicationRecord
  belongs_to :user
  
  validates :speaker, presence: true
  validates :word, presence: true, length: { maximum:65535}

end
