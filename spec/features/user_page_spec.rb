require 'spec_helper'

feature 'ユーザは、自分のトピックを確認したい' do
  include_context 'login'

  background do
    30.times { FactoryGirl.create(:topic, author: user) }
    user.reload

    visit user_path(user)
  end

  scenario '登録したトピック一覧が表示される' do
    expect(page.current_path).to eq user_path(user)

    within "#topics" do
      user.topics.first(25).each do |topic|
        expect(page).to have_css "a", text: topic.title
      end
    end
  end
end
