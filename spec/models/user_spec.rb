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
    end
  end
end