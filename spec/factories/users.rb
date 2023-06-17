FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { Faker::Internet.email }
    password              { '000abc' }
    password_confirmation { password }
    sei                   { '鈴木' }
    mei                   { '太郎' }
    sei_hurigana          { 'スズキ' }
    mei_hurigana          { 'タロウ' }
    dateofbirth           { Date.new(1990, 1, 1) }
  end
end
