require 'spec_helper'

feature 'ユーザは、Markdownでトピック内容を編集したい' do
  include_context 'login'

  background { FactoryGirl.create_list(:node, 3) }

  scenario 'Markdownで内容を入力し、保存するとHTMLに変換される' do
    visit new_topic_path

    md_body = "## head 2\n* 11\n* 12\n\n"

    fill_in 'topic_title', with: 'markdown test'
    fill_in 'topic_body', with: md_body
    click_button '保存'

    expect(page).to have_css 'h2', text: 'head 2'
    expect(page).to have_css 'li', text: '11'
    expect(page).to have_css 'li', text: '12'

    new_topic = Topic.last

    visit edit_topic_path(new_topic)

    expect(page).to have_content md_body

    fill_in 'topic_body', with: md_body * 3

    click_button '保存'

    expect(page).to have_css 'h2', text: 'head 2', count: 3
    expect(page).to have_css 'li', text: '11', count: 3
    expect(page).to have_css 'li', text: '12', count: 3
  end
end
