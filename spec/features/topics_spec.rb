require 'spec_helper'

feature "ゲストは、すべてのトピックを見たい" do
  background { 10.times { FactoryGirl.create(:topic) } }

  scenario '/にアクセスすると、トピックリストが表示される' do
    visit root_path

    expect(page).to have_css ".infos .title", text: "topic title"
  end
end
