# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Config.locale = :en; Faker::Internet.email }
    password 'testtest'
    name { Faker::Config.locale = :en; Faker::Name.name }
  end
end
