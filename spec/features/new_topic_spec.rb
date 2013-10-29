require "spec_helper"

feature 'ユーザは、トピックを新規したい' do
  include_context 'login'

  background do
    3.times { FactoryGirl.create(:node) }
    visit node_path(Node.all.sample)
  end

  scenario 'トピック一覧画面にトピック新規リンクが表示される' do
    expect(page).to have_css "a", text: 'トピックを作成'
  end

  scenario 'トピック新規リンクで画面遷移し、必要な情報を入力し新規作成出来る' do
    click_link 'トピックを作成'

   expect(page.current_path).to eq new_topic_path

    select Node.all.sample.name, from: 'topic_node_id'
    fill_in "topic_title",  with: Faker::Lorem.sentence
    fill_in "topic_body",  with: Faker::Lorem.paragraph

    click_button '保存'

    new_topic = Topic.last
    expect(page.current_path).to eq topic_path(new_topic)
    expect(page).to have_content new_topic.title
    expect(page).to have_content new_topic.body
  end
end
