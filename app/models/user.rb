class User < ApplicationRecord

  # dependent: :destroyは、has_manyで使えるオプションです。 1:Nの関係において、
  # 「1」のデータが削除された場合、関連する「N」のデータも削除される設定です。
  # この設定では、Userのデータが削除されたとき、そのUserが投稿したコメントデータも一緒に削除されます。
   has_many :book_comments, dependent: :destroy
   has_many :favorites, dependent: :destroy


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
