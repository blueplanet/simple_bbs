require 'spec_helper'

feature "ゲストはトピックの詳細を見たい" do
  let!(:topic) { FactoryGirl.create(:topic) }

  scenario 'トピック一覧でタイトルをクリックすると、トピック詳細ページが表示される' do
    visit root_path
    click_link topic.title

    expect(page.current_path).to eq topic_path(topic)
    expect(page).to have_css "h3.topic-title", text: topic.title
    expect(page).to have_css ".panel-body", text: topic.body

    visit node_path(topic.node)

    click_link topic.title

    expect(page.current_path).to eq topic_path(topic)
    expect(page).to have_css "h3.topic-title", text: topic.title
    expect(page).to have_css ".panel-body", text: topic.body
  end
end
