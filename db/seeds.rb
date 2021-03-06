# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PASSWORD = 'supersecret'

 User.destroy_all
 Answer.destroy_all
 Question.destroy_all
 Tag.destroy_all

super_user = User.create(
  first_name: 'Jon',
  last_name: 'Snow',
  email: 'js@winterfell.gov',
  password: PASSWORD,
  is_admin: true
)

10.times.each do
  first_name= Faker::Name.first_name
  last_name= Faker::Name.last_name

  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD
  )
end

users = User.all

30.times.each do
  Tag.create(
    name: Faker::Book.genre
  )
end

tags = Tag.all

 1000.times.each do
   q = Question.create(
     title: Faker::Dog.name,
     body: Faker::Lorem.paragraph,
     view_count: rand(0..5000),
     user: users.sample
   )
   if q.valid?
   rand(0..10).times.each do
     a = Answer.create(
       body: Faker::Seinfeld.quote,
       question: q,
       user: users.sample
     )
     users.shuffle.slice(0..rand(users.count)).each do |user|
       Vote.create(
         answer: a,
         user: user,
         is_up: [true,false].sample
       )
     end

   end

 end
 q.tags = tags.shuffle.slice(0..rand(5))
 q.user_likes = users.shuffle.slice(0..rand(users.count))

end

 questions = Question.all
 answers = Answer.all

 puts Cowsay.say "Created #{questions.count} questions", :ghostbusters
 puts Cowsay.say "Created #{answers.count} answers", :sheep
 puts Cowsay.say "Created #{users.count} users", :tux
 puts Cowsay.say "Created #{tags.count} tags", :tux
 puts "Login as admin with #{super_user.email} and password of #{PASSWORD}"
