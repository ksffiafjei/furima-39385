require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe 'validations' do
    before do
      @user = FactoryBot.create(:user) 
      @item = FactoryBot.create(:item) 
      @purchase_address = FactoryBot.build(:purchase_address, user_id: @user.id, item_id: @item.id)
    end

    context '正常系' do
      it 'すべてが入力できたら良い' do
        expect(@purchase_address).to be_valid
      end

      it '建物名が空でも購入できること' do
        @purchase_address.buildingname = ''
        expect(@purchase_address).to be_valid
      end
    end

    context '異常系' do
      it '郵便番号が空白であること' do
        @purchase_address.postal_code = nil
        expect(@purchase_address).to be_invalid
        expect(@purchase_address.errors[:postalcode]).to include("can't be blank")
      end

      it '郵便番号は『３桁ハイフン４桁』半角英数字でないと保存できないこと' do
        @purchase_address.postalcode = "1234567"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid. Should be in the format XXX-XXXX")
      end

      it '都道府県が１にされている場合は購入できないこと' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address).to be_invalid
      end

      it '市区町村が空白であること' do
        @purchase_address.city = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空白であること' do
        @purchase_address.streetaddress = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Streetaddress can't be blank")
      end

      it "電話番号は10桁以上11桁以内の半角数値のみ保存可能であり、ハイフンが含まれている場合は保存できないこと" do
        @purchase_address.user_id = @user.id
        @purchase_address.phonenumber = '090-1234-5678'       
        @purchase_address.valid?
        expect(@purchase_address.errors[:phonenumber]).to include("is invalid. Enter a valid phone number.")
      end

      it '電話番号が空白であること' do
        @purchase_address.user_id = @user.id
        @purchase_address.phonenumber = ''       
        @purchase_address.valid?
        expect(@purchase_address.errors[:phonenumber]).to include("can't be blank")
      end

      it 'userが紐づいていないと購入できないこと' do
        @purchase_address.user_id = nil 
        @purchase_address.valid?
        expect(@purchase_address.errors[:user_id]).to include("can't be blank")
      end

      it 'itemが紐づいていなければ購入できないこと' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors[:item_id]).to include("can't be blank")
      end

      it "tokenが空では登録できないこと" do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end