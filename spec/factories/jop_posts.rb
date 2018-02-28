FactoryBot.define do
  salary_min_val = rand(30_001..50_000)
  factory :job_post do
    association :user, factory: :user
    sequence(:title) { |n| Faker::Job.title + "_#{n}"}
    description { Faker::Hacker.say_something_smart }
    company { Faker::Company.name }
    role { Faker::Company.buzzword }
    salary_min salary_min_val
    salary_max { salary_min_val + rand(5000..35000) }
    location {  Faker::Address.city  }
  end
end


#
# create_table "job_posts", force: :cascade do |t|
#   title"
#   description"
#   company"
#   role"
#   location"
#   "salary_min"
#   "salary_max"
#    "created_at", null: false
#    "updated_at", null: false
# en
