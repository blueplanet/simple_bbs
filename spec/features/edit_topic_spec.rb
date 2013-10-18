require 'spec_helper'

feature 'ユーザは、自分のトピックを編集したい' do
  include_context 'login'

  let(:topic) { FactoryGirl.create(:topic, author: user) }

  scenario 'トピックページに編集リンクが表示される' do
    visit topic_path(topic)

    expect(page).to have_css 'h3 a', text: '編集'
  end

  scenario '編集リンクをクリックすると、編集ページに遷移される'

  scenario '編集ページで、タイトルまたは内容を修正し、保存ボタンをクリックすると、保存される'
end
