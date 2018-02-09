# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
 Answer.destroy_all
 Question.destroy_all

 1000.times.each do
   q = Question.create(
     title: Faker::Dog.name,
     body: Faker::Lorem.paragraph,
     view_count: rand(0..5000)
   )
   if q.valid?
   rand(0..10).times.each do
     Answer.create(
       body: Faker::Seinfeld.quote,
       question: q
     )
   end
 end
 end

 questions = Question.all
 answers = Answer.all

 puts Cowsay.say "Created #{questions.count} questions", :ghostbusters
 puts Cowsay.say "Created #{answers.count} answers", :sheep
