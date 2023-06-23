require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '正常系' do
      it 'すべてが保存できたら良い' do
        expect(@item).to be_valid
      end
    end

    context '異常系' do
      it '商品画像が空白であること' do
        @item.image = nil
        expect(@item).to be_invalid
        expect(@item.errors[:image]).to include("can't be blank")
      end

      it '商品名が空白であること' do
        @item.productname = ''
        expect(@item).not_to be_valid
        expect(@item.errors[:productname]).to include("can't be blank")
      end

      it '商品の説明が空白であること' do
        @item.description = ''
        expect(@item).not_to be_valid
        expect(@item.errors[:description]).to include("can't be blank")
      end

      it 'category が空であること' do
        @item.category_id = '---'
        @item.valid?
        expect(@item.errors[:category]).to include("can't be blank")
      end

      it '商品の状態が空であること' do
        @item.status_id = '---'
        @item.valid?
        expect(@item.errors[:status]).to include("can't be blank")
      end

      it '配送料の負担が空であること' do
        @item.shippingcostresponsibility_id = '---'
        @item.valid?
        expect(@item.errors[:shippingcostresponsibility]).to include("can't be blank")
      end

      it '発送元の地域が空であること' do
        @item.prefecture_id = '---'
        @item.valid?
        expect(@item.errors[:prefecture]).to include("can't be blank")
      end

      it '発送までの日数が空であること' do
        @item.deliveryday_id = '---'
        @item.valid?
        expect(@item.errors[:deliveryday]).to include("can't be blank")
      end

      it '価格が空白であること' do
        @item.price = ''
        expect(@item).not_to be_valid
        expect(@item.errors[:price]).to include("can't be blank")
      end

      it '価格が300円未満であること' do
        @item.price = 100
        expect(@item).not_to be_valid
        expect(@item.errors[:price]).to include('must be greater than or equal to 300')
      end

      it '価格が9999999円以上であること' do
        @item.price = 10_000_000
        expect(@item).not_to be_valid
        expect(@item.errors[:price]).to include('must be less than or equal to 9999999')
      end

      it 'userが紐づいていないと保存できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
