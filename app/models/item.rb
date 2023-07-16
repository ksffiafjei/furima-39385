class Item < ApplicationRecord
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shippingcostresponsibility
  belongs_to :prefecture
  belongs_to :deliveryday
  belongs_to :user
  has_one :purchase

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
  validate :validate_ids

  private

  def validate_ids
    errors.add(:category, "can't be blank") if category.present? && category.id <= 1
    errors.add(:status, "can't be blank") if status.present? && status.id <= 1
    if shippingcostresponsibility.present? && shippingcostresponsibility.id <= 1
      errors.add(:shippingcostresponsibility,
                 "can't be blank")
    end
    errors.add(:prefecture, "can't be blank") if prefecture.present? && prefecture.id <= 1
    errors.add(:deliveryday, "can't be blank") if deliveryday.present? && deliveryday.id <= 1
  end
end
