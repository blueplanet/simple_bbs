require 'spec_helper'
include ActionView::Helpers::DateHelper

feature 'ゲストは、トピックの書き込みを見たい' do
  let(:topic) { FactoryGirl.create(:topic_with_replies) }

  context "トピックページにアクセスすると" do
    before { visit topic_path(topic) }

    scenario 'トピックページにアクセスすると、書き込み一覧が表示される' do
      expect(page).to have_css '.panel-heading', text: "合計 #{topic.replies.count} 件"

      topic.replies.each do |reply|
        expect(page).to have_css "#replies .reply .body", text: reply.body
      end
    end

    scenario '最新の書き込み情報が表示される' do
      last_reply = topic.replies.last

      expect(last_reply).to_not be_nil
      expect(page).to have_css ".info.leader", text: "さんが #{time_ago_in_words(last_reply.created_at)} 書き込みました"
    end
  end
end

feature 'ユーザは、トピックに対して書き込みしたい' do
  include_context 'login'
  let(:topic) { FactoryGirl.create(:topic_with_replies) }
  before { visit topic_path(topic) }

  scenario 'トピックページに書き込みフォームが表示される' do
    expect(page).to have_css "form#new_reply"
  end

  scenario '書き込みフォームに内容を入力し、書き込むボタンをクリックすると、書き込みが追加される' do
    body = Faker::Lorem.paragraph
    fill_in "reply_body",  with: body
    click_button '書き込む'

    expect(page.current_path).to eq topic_path(topic)

    within "#replies .reply:last-child" do
      expect(page).to have_css "span.name", text: user.name
      expect(page).to have_css ".body", text: body
    end
  end

  context '自分の書き込みの場合' do
    background do
      body = Faker::Lorem.paragraph
      fill_in "reply_body",  with: body
      click_button '書き込む'

      topic.reload
    end

    scenario '編集ボタンが表示される' do
      within("#replies .reply:last-child") do
        expect(page).to have_css ".info a", text: '編集'
      end
    end

    scenario '編集ボタンをクリックすると、書き込みページに遷移される' do
      within("#replies .reply:last-child") do
        find(:link, '編集').click
      end

      expect(page.current_path).to eq edit_topic_reply_path(topic, topic.reload.replies.last)
      expect(page).to have_css "form", text: topic.replies.last.body
    end

    context "書き込み編集ページで" do
      background do
        within("#replies .reply:last-child") do
          find(:link, '編集').click
        end
      end

      scenario '内容を修正し、保存ボタンを押すと、編集が保存される' do
        new_body = Faker::Lorem.paragraph
        fill_in "reply_body",  with: new_body
        click_button '保存'

        expect(page.current_path).to eq topic_path(topic)
        expect(page).to have_css '.reply .body', text: new_body
      end

      scenario '削除ボタンをクリックすると、書き込みが削除される' do
        body = topic.replies.last.body

        click_link '削除'

        expect(page.current_path).to eq topic_path(topic)
        expect(page).to have_content I18n.t('replies.notices.deleted')
        expect(page).to_not have_content body
      end
    end
  end
end
