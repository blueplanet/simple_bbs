# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reply do
    sequence(:body) {|n| "reply body #{n}"}
    topic { FactoryGirl.create(:topic) }
    anthor { FactoryGirl.create(:user) }
  end
end
