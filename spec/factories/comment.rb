FactoryBot.define do
  factory :comment do
    association :user
    association :post
    body { Faker::Lorem.paragraph_by_chars }
  end
end