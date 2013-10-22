require 'spec_helper'

feature 'ユーザは、自分の情報を確認したい' do
  include_context 'login'

  context "#topics" do
    background do
      30.times { FactoryGirl.create(:topic, author: user) }
      user.reload

      visit topics_user_path(user.reload)
    end

    scenario '登録したトピック一覧が表示される' do
      within "#topics" do
        user.topics.first(25).each do |topic|
          expect(page).to have_css "a", text: topic.title
        end
      end
    end
  end

  context "#replies" do
    background do
      5.times do
        FactoryGirl.create(:reply)
      end

      visit user_path(user.reload)
    end

    scenario '書き込み一覧が表示される' do
      within "#account #replies" do
        user.replies.first(25).each do |reply|
          expect(page).to have_css 'a', text: reply.topic.title
          expect(page).to have_content reply.body
        end
      end
    end
  end
end
