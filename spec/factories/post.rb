FactoryBot.define do
  factory :post do
    association :user
    title { Faker::Lorem.sentence(word_count: 5) }
    body { Faker::Lorem.paragraph_by_chars }
  end
end