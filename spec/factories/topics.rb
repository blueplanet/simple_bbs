FactoryGirl.define do
  factory :topic do
    sequence(:title) {|n| "topic title #{n}" }
    sequence(:body) {|n| "topic body .... #{n}"}

    node_id { FactoryGirl.create(:node).id }
    author { FactoryGirl.create(:user) }

    factory :topic_with_replies do
      replies {
        FactoryGirl.create_list(:reply, 10)
      }
    end
  end
end
