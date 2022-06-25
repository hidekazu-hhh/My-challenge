class User < ApplicationRecord
  authenticates_with_sorcery!
  validates :password, length: { minimum: 4 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 255 }
  has_many :post_tags, dependent: :destroy
  has_many :tags,through: :post_tags
  has_many :posts, dependent: :destroy
  has_many :positive_words, dependent: :destroy
  
  enum role: { general: 0, admin: 1 }
  mount_uploader :avatar_image, AvatarImageUploader
  scope :created_user_week_ago, -> {  where(created_at: 1.week.ago.beginning_of_day..Date.today) }
end
  
  
