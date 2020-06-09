class Relationship < ApplicationRecord
  # Userモデルはフォローする側、フォローされる側２つ必要なので架空のモデルとしてfollowモデルを作る
  # フォローする側
  belongs_to :user
  # フォローされる側
  belongs_to :follow, class_name: 'User'
  validates :user_id, presence: true
  validates :follow_id, presence: true
end
