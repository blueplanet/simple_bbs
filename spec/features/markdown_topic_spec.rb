require 'spec_helper'

feature 'ユーザは、Markdownでトピック内容を編集したい' do
  include_context 'login'

  background do
    FactoryGirl.create(:node)
  end

  scenario 'Markdownで内容を入力し、保存するとHTMLに変換される' do
    pending
    visit new_topic_path

    md_body = '## head 2\n* 11\n*12'

    fill_in 'topic_body', with: md_body
    click_button '保存'

    expect(page).to have_css 'h2', text: 'head 2'
    expect(page).to have_css 'ul li:eq(0)', text: '11'
    expect(page).to have_css 'ul li:eq(0)', text: '12'
  end
end
