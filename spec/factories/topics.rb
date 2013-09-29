FactoryGirl.define do
  factory :topic do
    sequence(:title) {|n| "topic title #{n}" }
    sequence(:body) {|n| "topic body .... #{n}"}
    node { FactoryGirl.create(:node) }
  end
end
