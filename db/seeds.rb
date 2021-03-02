# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

5.times do
  @user = User.create(
    email: Faker::Internet.email,
    name: Faker::Name.name,
    password: Faker::Alphanumeric.alphanumeric(number: 10)
  )
end

10.times do
  Post.create(
    title: Faker::Lorem.sentence(word_count: 5),
    body: Faker::Lorem.paragraph_by_chars,
    user_id: rand(1..5)
  )
end

50.times do
  post = Post.find(rand(1..10))
  comment = post.comments.new(
    body: Faker::Lorem.sentence(word_count: 3),
    user_id: rand(1..5),
    post_id: rand(1..10)
  )
  comment.save
end