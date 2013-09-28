require 'spec_helper'

feature "ゲストは、すべてのトピックを見たい" do
  background { 50.times { FactoryGirl.create(:topic) } }

  scenario 'root_path にアクセスすると、トピックリストが表示される' do
    visit root_path

    expect(page).to have_css ".infos .title", text: "topic title", count: 25
  end
end
