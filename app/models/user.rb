class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :password, presence: true, length: { minimum: 6 }, format: { with: /\A[a-zA-Z0-9]+\z/ }
  validates :password_confirmation, presence: true
  validates :sei, presence: true
  validates :mei, presence: true
  validates :sei_hurigana, presence: true, format: { with: /\A[ァ-ンー－]+\z/ }
  validates :mei_hurigana, presence: true, format: { with: /\A[ァ-ンー－]+\z/ }
  validates :dateofbirth, presence: true
end
