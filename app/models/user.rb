class User < ApplicationRecord

  # dependent: :destroyは、has_manyで使えるオプションです。 1:Nの関係において、
  # 「1」のデータが削除された場合、関連する「N」のデータも削除される設定です。
  # この設定では、Userのデータが削除されたとき、そのUserが投稿したコメントデータも一緒に削除されます。

  # いいね、コメント--------------------------------------------
   has_many :book_comments, dependent: :destroy
   has_many :favorites, dependent: :destroy


  # フォローフォロワー-------------------------------------
  has_many :active_relationshiops, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationshiops, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower


def followed_users
 User.where(id: following.select(:followed_id))
end

def follow(user)
  following << user
end

# このメソッド(following.delete(user))が使用される場合、ユーザーがフォロー解除するために使用されます。
# 例えば、「フォロー中」ボタンをクリックした際に、このメソッドを実行して、現在のユーザーがフォローしているユーザーから
# クリックされたユーザーを削除することができます。
# また、このメソッドを使用することで、関連する中間テーブルのレコードも自動的に削除されるため、
# データベースの整合性が保たれます。

def unfollow(user)
  following.delete(user)
end

# following.include?(user)は、引数で渡されたユーザーが、followingに含まれているかどうかを判定することができる

def following?(user)
  following.include?(user)
end

# --------------------------------------------------------------------------------------------------------

def like(book)
  favorites.create(book_id: book.id)
end

def unlike(book)
  favorites.find_by(book_id: book.id).destroy
end

def like?(book)
  favorites.find_by(book_id: book.id).present?
end


  # -------------------------------------------------------------------------------------------------

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # -------------------------------------------------------------------------------------------------

  has_many :books
  has_one_attached :profile_image

  # -------------------------------------------------------------------------------------------------


  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  # -------------------------------------------------------------------------------------------------



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
