require 'spec_helper'

feature "ゲストは、すべてのトピックを見たい" do
  background do
    node1 = FactoryGirl.create(:node)
    node2 = FactoryGirl.create(:node)
    node3 = FactoryGirl.create(:node)

    10.times { FactoryGirl.create(:topic, node: node1) }
    20.times { FactoryGirl.create(:topic, node: node2) }
    30.times { FactoryGirl.create(:topic, node: node3) }
  end

  scenario 'root_path にアクセスすると、トピックリストが表示される' do
    visit root_path

    Topic.first(25).each do |topic|
      expect(page).to have_css ".infos .title", text:topic.title
      expect(page).to have_css ".info .node", text: topic.node.name
    end
  end

  scenario 'トピックは、書き込みが多い順でソートされる' do
    t1 = Topic.all.sample
    FactoryGirl.create_list(:reply, 20, topic: t1)
    t2 = Topic.all.sample
    FactoryGirl.create_list(:reply, 15, topic: t2)
    t3 = Topic.all.sample
    FactoryGirl.create_list(:reply, 12, topic: t3)

    visit root_path

    expect(page).to have_css '#topics li:nth-child(1) .infos .title', text: t1.title
    expect(page).to have_css '#topics li:nth-child(2) .infos .title', text: t2.title
    expect(page).to have_css '#topics li:nth-child(3) .infos .title', text: t3.title
  end

  scenario 'トピックのノードをクリックすると、該当ノード配下のトピック一覧が表示される' do
    node = Topic.first.node

    visit root_path
    first(".info .node").click

    expect(page.current_path).to eq node_path(node)
    expect(page).to have_css "h3.node-title", text: node.name
    expect(page).to have_css ".panel-heading", text: node.description

    node.topics.first(25).each do |topic|
      expect(page).to have_css ".infos .title", text: topic.title
    end
  end
end
