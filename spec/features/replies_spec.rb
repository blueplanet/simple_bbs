require 'spec_helper'

feature 'ゲストは、トピックの書き込みを見たい' do
  let(:topic) { FactoryGirl.create(:topic_with_replies) }

  scenario 'トピックページにアクセスすると、書き込み一覧が表示される' do
    visit topic_path(topic)

    expect(page).to have_css '.panel-heading', text: "合計 #{topic.replies.count} 件"

    topic.replies.each do |reply|
      expect(page).to have_css "#replies .reply .body", text: reply.body
    end
  end
end
