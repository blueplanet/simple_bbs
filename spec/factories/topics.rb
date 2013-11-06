FactoryGirl.define do
  factory :topic do
    sequence(:title) {|n| "topic title #{n}" }
    sequence(:body) {|n| "topic body .... #{n}"}
    body_html { body }

    node_id { FactoryGirl.create(:node).id }
    author { FactoryGirl.create(:user) }

    factory :topic_with_replies do
      replies_count 10
      replies {
        FactoryGirl.create_list(:reply, 10)
      }
    end
  end
end
