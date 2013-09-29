require 'spec_helper'
include ActionView::Helpers::DateHelper

feature 'ゲストは、トピックの書き込みを見たい' do
  let(:topic) { FactoryGirl.create(:topic_with_replies) }

  context "トピックページにアクセスすると" do
    before { visit topic_path(topic) }

    scenario 'トピックページにアクセスすると、書き込み一覧が表示される' do
      expect(page).to have_css '.panel-heading', text: "合計 #{topic.replies.count} 件"

      topic.replies.each do |reply|
        expect(page).to have_css "#replies .reply .body", text: reply.body
      end
    end

    scenario '最新の書き込み情報が表示される' do
      last_reply = topic.replies.last

      expect(last_reply).to_not be_nil
      expect(page).to have_css ".info.leader", text: "さんが #{time_ago_in_words(last_reply.created_at)} 書き込みました"
    end
  end

end
