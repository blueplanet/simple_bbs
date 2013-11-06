require 'spec_helper'

feature 'ユーザは、自分のトピックを編集したい' do
  include_context 'login'

  let(:topic) { FactoryGirl.create(:topic, author: user) }
  before { visit topic_path(topic) }

  scenario 'トピックページに編集リンクが表示される' do
    expect(page).to have_css 'h3 a'
  end

  scenario '編集リンクをクリックすると、編集ページに遷移される' do
    first('h3 a').click

    expect(page.current_path).to eq edit_topic_path(topic)
  end

  scenario '編集ページで、タイトルまたは内容を修正し、保存ボタンをクリックすると、保存される' do
    title = Faker::Lorem.sentence
    body = Faker::Lorem.paragraph

    first('h3 a').click

    fill_in "topic_title",  with: title
    fill_in "topic_body",  with: body

    click_button '保存'

    expect(page.current_path).to eq topic_path(topic)
    expect(page).to have_content title
    expect(page).to have_content body
  end
end
