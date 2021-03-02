FactoryBot.define do 
  factory :user do 
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { Faker::Alphanumeric.alphanumeric(number: 10) }
  end
end