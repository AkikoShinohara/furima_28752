class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :password, presence: true, length: {minimum: 6},
            #英数字のみ可
            format: {with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "英数字以外の文字を含むことはできません"}
  validates :email, presence: true,
            # 重複不可
            uniqueness: { case_sensitive: false },
            # 英数字のみ可,@を挟んだemailの形になっているか
            format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "英数字以外の文字を含むことはできません" }  
  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: "全角文字を使用してください" } do
    validates :f_name
    validates :l_name
    validates :f_name_kana
    validates :l_name_kana
  end
  validates :birthday, presence: true

  has_many :items
  has_many :payments
end

