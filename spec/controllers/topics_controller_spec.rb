require 'spec_helper'

describe TopicsController do
  describe "GET 'index'" do
    before { get :index }

    it { response.should be_success }
    it { expect(assigns(:topics)).to_not be_nil }
  end

  describe "GET 'show'" do
    let!(:topic) { FactoryGirl.create(:topic_with_replies) }
    before { get :show, id: topic }

    it { expect(response).to be_success}
    it { expect(assigns(:topic)).to be_a(Topic) }
    it { expect(assigns(:last_reply)).to be_a(Reply) }
  end
end
