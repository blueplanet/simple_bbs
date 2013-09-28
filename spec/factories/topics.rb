FactoryGirl.define do
  factory :topic do
    sequence(:title) {|n| "topic title #{n}" }
    node { FactoryGirl.create(:node) }
  end
end
