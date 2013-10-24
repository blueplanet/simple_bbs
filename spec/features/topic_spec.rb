require 'spec_helper'

feature "ゲストはトピックの詳細を見たい" do
  let!(:topic) { FactoryGirl.create(:topic) }

  scenario 'トピック一覧でタイトルをクリックすると、トピック詳細ページが表示される' do
    visit root_path
    click_link topic.title

    expect(page.current_path).to eq topic_path(topic)
    expect(page).to have_css "h3.topic-title", text: topic.title
    expect(page).to have_css ".panel-body", text: topic.body
  end

  scenario 'ノードページでタイトルをクリックすると、トピック詳細ページが表示される' do
    visit node_path(topic.node)
    click_link topic.title

    expect(page.current_path).to eq topic_path(topic)
    expect(page).to have_css "h3.topic-title", text: topic.title
    expect(page).to have_css ".panel-body", text: topic.body
  end

  scenario 'トピック詳細ページで、トピックを作成したユーザ情報を見える' do
    visit topic_path(topic)

    expect(page).to have_css "a.topic-user", text: topic.author.name

    click_link topic.author.name

    expect(page.current_path).to eq user_path(topic.author)
  end

  scenario 'トピック詳細ページで、同一ノードの書き込み数が多いトピックが表示される' do
    10.times { FactoryGirl.create(:topic, node: topic.node) }
    top_topics = topic.node.reload.topics.sample(3)
    [3, 5, 10].each_with_index do |n, i|
      topic = top_topics[i]
      FactoryGirl.create_list(:reply, n, topic: topic)
    end

    visit topic_path(topic)

    within "#other_topics" do
      top_topics.each do |topic|
        expect(page).to have_css "a", text: topic.title
      end
    end
  end
end
