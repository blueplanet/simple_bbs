require "spec_helper"

describe UsersController do
  let(:user) { FactoryGirl.create(:user) }

  describe "GET show" do
    before { get :show, {id: user} }

    it { expect(response).to be_success }
    it { expect(assigns(:user)).to eq user }
    it { expect(assigns(:replies)).to_not be_nil}
  end

  describe "GET topics" do
    before { get :topics, {id: user} }

    it { expect(response).to be_success }
    it { expect(assigns(:user)).to eq user }
  end
end
