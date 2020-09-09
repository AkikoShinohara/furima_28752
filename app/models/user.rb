class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :password, presence: true, 
                       format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,100}+\z/i, message: ' Include both letters and numbers' }
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :f_name, :l_name, presence: true,
                              format: { with: /\A[一-龥ぁ-ん]/, message: 'Full-width characters' }
  validates :f_name_kana, :l_name_kana, presence: true,
                                        format: { with: /\A[ァ-ヶー－]+\z/, message: 'Full-width katakana characters' }
  validates :birthday, presence: true

  has_many :items, dependent: :destroy
  has_many :payments, dependent: :destroy
end
