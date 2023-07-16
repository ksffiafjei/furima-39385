class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :postalcode, :prefecture_id, :city, :token,
                :streetaddress, :buildingname, :phonenumber, :purchase, :user_id, :item_id

  with_options presence: true do
    validates :postalcode, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Should be in the format XXX-XXXX' }
    validates :prefecture_id
    validates :city
    validates :streetaddress
    validates :buildingname, allow_blank: true
    validates :phonenumber, format: { with: /\A[0-9]{10,11}\z/, message: 'is invalid. Enter a valid phone number.' }
    validates :user_id
    validates :item_id
    validates :token
  end

  validates :prefecture_id, exclusion: { in: [1], message: 'cannot be selected' }

  def save
    self.user_id = user_id
    self.item_id = item_id
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postalcode: postalcode, prefecture_id: prefecture_id, city: city, streetaddress: streetaddress,
                   buildingname: buildingname, phonenumber: phonenumber, purchase_id: purchase.id)
  end
end
