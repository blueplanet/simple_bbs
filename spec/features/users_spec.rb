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
