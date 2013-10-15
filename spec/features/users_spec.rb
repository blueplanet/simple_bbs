require 'spec_helper'

feature 'ゲストは、サインアップしたい' do
  scenario 'トップページにサインアップリンクが表示される' do
    visit root_path

    expect(page).to have_link "サインアップ"
  end
end
