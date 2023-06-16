require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  it 'メールアドレスが必須であること' do
    @user.email = nil
    expect(@user).to_not be_valid
    expect(@user.errors[:email]).to include("can't be blank")
  end

  it 'メールアドレスが一意性であること' do
    existing_user = FactoryBot.create(:user, email: 'test@example.com')
    @user.email = existing_user.email
    expect(@user).to_not be_valid
    expect(@user.errors[:email]).to include('has already been taken')
  end

  it 'メールアドレスは、@を含む必要があること' do
    @user.email = 'invalid_email'
    expect(@user).to_not be_valid
    expect(@user.errors[:email]).to include('is invalid')
  end

  it 'パスワードが必須であること' do
    @user.password = nil
    expect(@user).to_not be_valid
    expect(@user.errors[:password]).to include("can't be blank")
  end

  it 'パスワードは、6文字以上での入力が必須であること' do
    @user.password = '12345'
    expect(@user).to_not be_valid
    expect(@user.errors[:password]).to include('is too short (minimum is 6 characters)')
  end

  it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
    @user.password_confirmation = 'different_password'
    expect(@user).to_not be_valid
    expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
  end
end
