# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 Question.destroy_all

 100.times.each do
   Question.create(
     title: Faker::Movie.quote,
     body: Faker::Lorem.paragraph,
     view_count: rand(0..5000)
   )
 end

 questions = Question.all

 puts Cowsay.say "Created #{questions.count} questions", :ghostbusters
