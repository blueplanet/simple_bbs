FactoryGirl.define do
  factory :topic do
    sequence(:title) {|n| "topic title #{n}" }
    sequence(:body) {|n| "topic body .... #{n}"}
    node { FactoryGirl.create(:node) }

    factory :topic_with_replies do
      replies {
        FactoryGirl.create_list(:reply, 10)
      }
    end
  end
end
