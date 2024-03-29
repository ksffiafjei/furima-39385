class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :postalcode, :prefecture_id, :city, :token,
                :streetaddress, :buildingname, :phonenumber, :user_id, :item_id

  with_options presence: true do
    validates :postalcode, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Should be in the format XXX-XXXX' }
    validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
    validates :city
    validates :streetaddress
    validates :phonenumber, format: { with: /\A[0-9]{10,11}\z/, message: 'is invalid. Enter a valid phone number.' }
    validates :user_id
    validates :item_id
    validates :token
  end


  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postalcode: postalcode, prefecture_id: prefecture_id, city: city, streetaddress: streetaddress,
                   buildingname: buildingname, phonenumber: phonenumber, purchase_id: purchase.id)
  end
end

