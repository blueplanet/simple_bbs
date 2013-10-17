shared_context 'login' do
  let(:user) { FactoryGirl.create(:user) }

  before do
    visit root_path
    click_link 'サインイン'

    fill_in "user_email",  with: user.email
    fill_in "user_password",  with: user.password

    click_button 'サインイン'
  end
end
