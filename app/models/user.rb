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
  has_many :comments, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人
  has_many :favorites, dependent: :destroy

  enum role: { general: 0, admin: 1, guest: 2  }
  mount_uploader :avatar_image, AvatarImageUploader
  scope :created_user_week_ago, -> {  where(created_at: 1.week.ago.beginning_of_day..Date.today) }

  def own?(object)
    id == object.user_id
  end

   # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end
end
  
  
