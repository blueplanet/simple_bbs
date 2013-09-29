require 'spec_helper'

describe TopicsController do
  describe "GET 'index'" do
    before { get :index }

    it { response.should be_success }
    it { expect(assigns(:topics)).to_not be_nil }
  end

  describe "GET 'show'" do
    let!(:topic) { FactoryGirl.create(:topic) }
    before { get :show, id: topic }

    it { expect(response).to be_success}
    it { expect(assigns(:topic)).to be_a(Topic) }
  end
end
