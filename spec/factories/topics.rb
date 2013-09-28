FactoryGirl.define do
  factory :topic do
    sequence(:title) {|n| "topic title #{n}" }
  end
end
