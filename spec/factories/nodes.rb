# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :node do
    sequence(:name) {|n| "node #{n}" }
    sequence(:description) {|n| "node description #{n}" }
  end
end
