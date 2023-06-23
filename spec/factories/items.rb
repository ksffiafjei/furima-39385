FactoryBot.define do
  factory :item do
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
    productname                { 'Tシャツ' }
    description                { '2010年頃に購入した服です' }
    category_id                   { 2 }
    status_id                     { 2 }
    shippingcostresponsibility_id { 2 }
    prefecture_id                 { 2 }
    deliveryday_id                { 2 }
    price { 1200 }
    association :user
  end
end
