FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 8)
    password {password}
    password_confirmation {password}
    f_name                 {"田中"}
    l_name                 {"隆太郎"}
    f_name_kana            {"タナカ"}
    l_name_kana            {"リクタロウ"}
    birthday               {Date.today}
  end
end