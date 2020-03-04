# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..30).each { |i| User.create(username: "user-#{i}", fullname: "The User #{i}") }
u1 = User.first
(11..20).each { |i| u1.follow(User.find(i)) }
User.all.each do |u|
  2.times { |i| u.messages.create(text: "Message number #{i + 1} by #{u.fullname}") }
end
(11..15).each do |i|
  u = User.find(i)
  u.messages.each { |m| u1.like_message(m) }
end