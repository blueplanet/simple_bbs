require 'spec_helper'

feature "ゲストは、すべてのトピックを見たい" do
  background { 50.times { FactoryGirl.create(:topic) } }

  scenario 'root_path にアクセスすると、トピックリストが表示される' do
    visit root_path

    Topic.first(25).each do |topic|
      expect(page).to have_css ".infos .title", text:topic.title
      expect(page).to have_css ".info .node", text: topic.node.name
    end
  end
end
