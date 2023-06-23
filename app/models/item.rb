class Item < ApplicationRecord
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shippingcostresponsibility
  belongs_to :prefecture
  belongs_to :deliveryday
  belongs_to :user

  validates :image, presence: true
  validates :productname, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :status, presence: true
  validates :shippingcostresponsibility, presence: true
  validates :prefecture, presence: true
  validates :deliveryday, presence: true
  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :price, numericality: { only_integer: true }
  # validates :user_id, presence: true
end
