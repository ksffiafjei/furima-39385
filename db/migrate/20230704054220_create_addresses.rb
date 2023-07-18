class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :purchase, null: false, foreign_key: true
      t.string :postalcode, null: false
      t.integer :prefecture_id, null: false
      t.string :city, null: false
      t.string :streetaddress, null: false
      t.string :buildingname
      t.string :phonenumber, null: false
      t.timestamps
    end
  end
end
