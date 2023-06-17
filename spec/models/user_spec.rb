require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '正常系' do
      it 'すべてが保存できたら良い' do
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
    end
      
    context '異常系' do
      it 'メールアドレスが空白であること' do
        @user.email = nil
        @user.valid? 
        expect(@user.errors[:email]).to include("can't be blank")
      end

      it 'メールアドレスが一意性でない場合' do
        email = Faker::Internet.unique.email
        @user.email = email
        @user.save

        new_user = FactoryBot.build(:user, email: email)
        expect(new_user).not_to be_valid
      end

      it 'メールアドレスは、@を含んでいないこと' do
        @user.email = 'invalid_email'
        @user.valid?
        expect(@user.errors[:email]).to include('is invalid')
      end

      it 'パスワードが空白であること' do
        @user.password = nil
        @user.valid?
        expect(@user.errors[:password]).to include("can't be blank")
      end

      it 'パスワードが6文字未満の場合に無効であること' do
        @user.password = '12345'
        @user.valid?
        expect(@user.errors[:password]).to include('is too short (minimum is 6 characters)')
      end

      it 'パスワードとパスワード（確認）が一致しない場合にも無効であること' do
        @user.password = 'password'
        @user.password_confirmation = 'different_password'
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
      end

      it '英字のみでは無効であること' do
        @user.password = 'password'
        @user.password_confirmation = 'password'
        @user.valid?
        expect(@user.errors[:password]).to include('is invalid')
      end

      it '数字のみでは無効であること' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors[:password]).to include('is invalid')
      end
  
      it '全角では無効であること' do
        @user.password = 'パスワード'
        @user.password_confirmation = 'パスワード'
        @user.valid?
        expect(@user.errors[:password]).to include('is invalid')
      end

      it '姓が空では無効であること' do
        @user.sei = ''
        @user.valid?
        expect(@user.errors[:sei]).to include("can't be blank")
      end

      it '名が空では無効であること' do
        @user.mei = ''
        @user.valid?
        expect(@user.errors[:mei]).to include("can't be blank")
      end
  
      it '姓が半角文字が含まれている場合は無効であること' do
        @user.sei = 'Suzuki'
        @user.valid?
        expect(@user.errors[:sei]).to include('is invalid')
      end

      it '名が半角文字が含まれている場合は無効であること' do
        @user.mei = 'Tarou'
        @user.valid?
        expect(@user.errors[:mei]).to include('is invalid')
      end

      it '姓（ふりがな）が空では無効であること' do
        @user.sei_hurigana = ''
        @user.valid?
        expect(@user.errors[:sei_hurigana]).to include("can't be blank")
      end
  
      it '名（ふりがな）が空では無効であること' do
        @user.mei_hurigana = ''
        @user.valid?
        expect(@user.errors[:mei_hurigana]).to include("can't be blank")
      end
  
      it '姓（ふりがな）がカタカナ以外の文字が含まれている場合は無効であること' do
        @user.sei_hurigana = 'すずき'
        @user.valid?
        expect(@user.errors[:sei_hurigana]).to include('is invalid')
      end

      it '名（ふりがな）がカタカナ以外の文字が含まれている場合は無効であること' do
        @user.mei_hurigana = 'たろう'
        @user.valid?
        expect(@user.errors[:mei_hurigana]).to include('is invalid')
      end

      it '生年月日が空では無効であること' do
        @user.dateofbirth = nil
        @user.valid?
        expect(@user.errors[:dateofbirth]).to include("can't be blank")
      end
    end
  end
end