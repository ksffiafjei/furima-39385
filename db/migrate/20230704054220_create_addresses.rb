class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :purchase, foreign_key: true
      t.string :postalcode
      t.integer :prefecture_id
      t.string :city
      t.string :streetaddress
      t.string :buildingname
      t.string :phonenumber
      t.timestamps
    end
  end
end
