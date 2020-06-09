class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :email, presence: true
  validates :introduction, length: { maximum: 50 }

  attachment :profile_image
  has_many :books, dependent: :destroy

  # def email_required?
  #   false
  # end
  # def will_save_change_to_email?
  #   false
  # end

  # コメント機能
  has_many :book_comments, dependent: :destroy
  # いいね機能
  has_many :favorites, dependent: :destroy

  # フォロー機能
  # ========自分がフォローしているユーザーとの関連======
  # ①中間モデルRelationship
  has_many :relationships
  # ②M対Nの相手NのUserモデル
  has_many :followings, through: :relationships, source: :follow
  # ========自分がフォローされるユーザーとの関連========
  # ①中間モデルRelationship
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  # ②M対Nの相手NのUserモデル
  has_many :followers, through: :reverse_of_relationships, source: :user

  def follow(other_user)
    unless self == other_user # 自分以外の人であれば下記実行
      relationships.find_or_create_by(follow_id: other_user.id) # フォロー済みならRelation を返し、フォローしてなければフォロー関係を保存(create = new + save)する
    end
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship # relationship が存在すれば(=フォロー済みなら) destroy
  end

  # 自分はother_userをフォローしてるか？
  def following?(other_user)
    followings.include?(other_user)
  end

  # 検索機能
  def self.search(search, word)
    if search == "forward_match"
      User.where("name LIKE?", "#{word}%")
    elsif search == "backward_match"
      User.where("name LIKE?", "%#{word}")
    elsif search == "perfect_match"
      User.where("name =?", "#{word}")
    elsif search == "partial_match"
      User.where("name LIKE?", "%#{word}%")
    else
      User.all
    end
  end

  # 住所検索（JpPrefecture gem)
  validates :postal_code, presence: true, length: { is: 7 }, numericality: { only_integer: true }
  validates :city, presence: true
  validates :street, presence: true

  include JpPrefecture
  jp_prefecture :prefecture_code
  # postal_codeからprefecture_nameに変換するメソッドを用意
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  # prefecture_name2都道府県名を代入したらprefecture_codeに反映させるメソッド
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  # GooleMap導入のため緯度経度取得(本来不要)
  def address
    "%s %s" % [postal_code, city, street]
  end

  # 上記と同じ（下記はGH掲載）
  # def address
  #   [postal_code,city,street].compact.join(', ')
  # end
  # 下記不要
  # geocoded_by self.address
  # after_validation :geocode, if: :address_changed?

  # チャット
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms
end
