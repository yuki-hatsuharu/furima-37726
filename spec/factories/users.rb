FactoryBot.define do
  factory :user do
    nickname { Faker::Name }
    email { Faker::Internet.free_email }
    password { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    first_name { '隆太郎' }
    last_name { '山田' }
    first_name_kana { 'リクタロウ' }
    last_name_kana { 'ヤマダ' }
    birthday { Faker::Date.birthday }
  end
end
