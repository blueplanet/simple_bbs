require 'spec_helper'

feature 'ユーザは、あるトピックをお気に入り出来ます' do
  include_context 'login'
  let(:topic) { FactoryGirl.create(:topic) }

  scenario 'トピックページにお気に入りリンクをクリックすると、お気に入りリストに追加される' do
    visit topic_path(topic)
    click_link 'お気に入りに追加'

    visit user_path(user)
    click_link 'お気に入りリスト'

    expect(page).to have_css 'a', text: topic.title
  end
end
