class Book < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 199 }
  # いいね機能
  has_many :favorites, dependent: :destroy
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  # コメント機能
  has_many :book_comments, dependent: :destroy
  # 検索機能
  def self.search(search, word)
    if search == "forward_match"
      @books = Book.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @books = Book.where("title LIKE?", "%#{word}")
    elsif search == "perfect_match"
      @books = Book.where("title =?", "#{word}")
    elsif search == "partial_match"
      @books = Book.where("title LIKE?", "%#{word}%")
    else
      @books = Book.all
    end
  end
end
