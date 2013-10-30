require 'spec_helper'

feature 'ユーザは、Markdownで書き込み内容を編集したい' do
  include_context 'login'

  let(:node) { FactoryGirl.create_list(:node, 3).sample }
  let(:topic) { FactoryGirl.create(:topic, node: node) }

  scenario 'Markdownで内容を入力し、書き込むとHTMLに変換される' do
    visit topic_path(topic)

    within '#new_reply' do
      fill_in 'reply_body', with: "### まとめ\n* 21\n* 22"
      click_button '書き込む'
    end

    expect(page).to have_css 'h3', text: 'まとめ'
    expect(page).to have_css 'li', text: '21'
    expect(page).to have_css 'li', text: '22'

    within '#replies' do
      first(:link, '編集').click
    end

    fill_in 'reply_body', with: "### 次のアクション\n* 31\n*32\n"
    click_button '保存'

    expect(page).to have_css 'h3', text: '次のアクション'
    expect(page).to have_css 'li', text: '31'
    expect(page).to have_css 'li', text: '32'
  end
end
