FactoryBot.define do
  factory :purchase_address do
    postalcode             { '344-7777' }
    prefecture_id          {     3    }
    city                   {   '緑区' }
    streetaddress          {   '青山1-1' }
    buildingname           {   'ビル'   }
    phonenumber           { '09012345678' }
    token                 {'tok_abcdefghijk00000000000000000'}

    association :user
    association :item


  end
end
