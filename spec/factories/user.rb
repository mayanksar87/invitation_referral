FactoryBot.define do
  factory :user, class: User do
    email { Faker::Internet.email }
     password { '123456' }
  end
end