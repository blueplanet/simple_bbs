require 'spec_helper'

describe TopicsController do
  let(:user) { FactoryGirl.create(:user) }

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

  describe "GET new" do
    before do
      sign_in user
      get :new, {}, {user_id: user}
    end

    it { expect(response).to be_success }
    it { expect(assigns(:topic)).to be_a_new(Topic) }
    it { expect(assigns(:nodes)).to eq Node.all }
  end

  describe "GET edit" do
    let(:topic) { FactoryGirl.create(:topic) }

    before do
      sign_in user
      get :edit, {id: topic}, {user_id: user}
    end

    it { expect(response).to be_success }
    it { expect(assigns(:topic)).to be_a(Topic)}
  end

  describe "POST create" do
    before { sign_in user }

    context "正常パラメータの場合" do
      it "topic_pathにリダイレクト" do

        post :create, {topic: FactoryGirl.attributes_for(:topic) }

        expect(response).to redirect_to(topic_path(Topic.last))
        expect(flash[:notice]).to eq I18n.t('topics.created')
      end
    end

    context "異常パラメータの場合" do
      it "topic_pathにリダイレクトされない" do
        post :create, {topic: FactoryGirl.attributes_for(:topic, title: nil) }, {user_id: user} 
        expect(response).to_not redirect_to topic_path(Topic.last)
      end
    end
  end
end
