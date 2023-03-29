class Book < ApplicationRecord

  # スコープ機能とは、モデル側であらかじめ特定の条件式に対して名前をつけて定義し
  # その名前でメソッドの様に条件式を呼び出すことが出来る仕組みのこと
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }

  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }


 #過去７日間の投稿を表示させる
 scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
 scope :created_2days, -> { where(created_at: 2.days.ago.all_day) }
 scope :created_3days, -> { where(created_at: 3.days.ago.all_day) }
 scope :created_4days, -> { where(created_at: 4.days.ago.all_day) }
 scope :created_5days, -> { where(created_at: 5.days.ago.all_day) }
 scope :created_6days, -> { where(created_at: 6.days.ago.all_day) }

 # 過去7日分の投稿(↑）をリファクタリングすることができるっぽい？
# リファクタリングとは、既存のコードを改善し、保守性を向上させるプロセス
    # ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
# scope :created_days_ago, ->(n) { where(created_at: n.days.ago.all.day) }
 
 
 
 scope :created_on, ->(date) { where(created_at: date.all.day) }



  has_many :book_comments, dependent: :destroy
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}


  def favorites_count
    self.favorites.count
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

    def favorited_by?(user)
    favorites.exists?(user_id: user.id)
    end
end
