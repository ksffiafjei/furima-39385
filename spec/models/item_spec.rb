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

      it 'カテゴリーが選択されていないこと' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors[:category]).to include("can't be blank")
      end

      it '商品の状態が選択されていないこと' do
        @item.status_id = nil
        @item.valid?
        expect(@item.errors[:status]).to include("can't be blank")
      end

      it '配送料の負担が選択されていないこと' do
        @item.shippingcostresponsibility_id = nil
        @item.valid?
        expect(@item.errors[:shippingcostresponsibility]).to include("can't be blank")
      end

      it '発送元の地域が選択されていないこと' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors[:prefecture]).to include("can't be blank")
      end

      it '発送までの日数が選択されていないこと' do
        @item.deliveryday_id = nil
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

      it '数値が全角であること' do
        @item.price = '１０００'
        expect(@item).not_to be_valid
        expect(@item.errors[:price]).to include('is not a number')
      end
    end
  end
end
