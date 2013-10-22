require "spec_helper"

describe UsersController do
  let(:user) { FactoryGirl.create(:user) }

  describe "GET show" do
    before { get :show, {id: user} }

    it { expect(response).to be_success }
    it { expect(assigns(:user)).to eq user }
  end
end
