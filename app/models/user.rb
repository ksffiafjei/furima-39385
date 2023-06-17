class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :password,  length: { minimum: 6 }, format:  { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/ }
  validates :sei, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
  validates :mei, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
  validates :sei_hurigana, presence: true, format: { with: /\A[ァ-ヶー]+\z/ }
  validates :mei_hurigana, presence: true, format: { with: /\A[ァ-ヶー]+\z/ }
  validates :dateofbirth, presence: true
end
