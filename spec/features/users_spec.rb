require 'spec_helper'

feature 'ゲストは、サインアップしたい' do
  background do
    Faker::Config.locale = :en
    visit root_path
  end

  scenario 'トップページにサインアップリンクが表示される' do
    expect(page).to have_link "サインアップ"
  end

  scenario 'サインアップページに遷移し、メールとパスワードでサインアップ出来る' do
    click_link 'サインアップ'

    expect {
      fill_in "user_email",  with: Faker::Internet.email
      fill_in "user_password",  with: 'testtest'
      fill_in "user_password_confirmation",  with: 'testtest'

      click_button 'サインアップ'
    }.to change(User, :count).by(1)
  end
end

feature 'ゲストは、サインアップしたいサインしたい' do
  given(:user) { FactoryGirl.create(:user) }

  scenario 'サインイン画面でサインイン出来る' do
    visit root_path
    expect(page).to have_css 'a', text: 'サインアップ'
    expect(page).to have_css 'a', text: 'サインイン'

    visit new_user_session_path

    fill_in "user_email",  with: user.email
    fill_in "user_password",  with: user.password

    click_button 'サインイン'

    expect(page.current_path).to eq root_path

    expect(page).to have_css 'a', text: user.name
    expect(page).to_not have_css 'a', text: 'サインアップ'
    expect(page).to_not have_css 'a', text: 'サインイン'
    expect(page).to have_css 'a', text: 'サインアウト'
  end
end
