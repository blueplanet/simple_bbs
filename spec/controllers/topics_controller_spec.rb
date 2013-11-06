require 'spec_helper'

describe TopicsController do
  let(:user) { FactoryGirl.create(:user) }

  describe "GET 'index'" do
    before { get :index }

    it { response.should be_success }
    it { expect(assigns(:topics)).to_not be_nil }
    it { expect(assigns(:hot_nodes)).to_not be_nil }
  end

  describe "GET 'show'" do
    let!(:topic) { FactoryGirl.create(:topic_with_replies) }
    before { get :show, id: topic }

    it { expect(response).to be_success}
    it { expect(assigns(:topic)).to be_a(Topic) }
    it { expect(assigns(:replies)).to eq topic.replies.page 1 }
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

  describe "POST preview" do
    before do
      sign_in user
      post :preview, {body: '## title2'}
    end

    it { expect(response).to be_success }
    it { expect(JSON.parse(response.body)).to eq ({"body_html" => "<h2>title2</h2>\n"}) }
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
        expect(flash[:notice]).to eq I18n.t('topics.notices.created')
      end
    end

    context "異常パラメータの場合" do
      it "topic_pathにリダイレクトされない" do
        post :create, {topic: FactoryGirl.attributes_for(:topic, title: nil) }

        expect(response).to_not redirect_to topic_path(Topic.last)
      end
    end
  end

  describe "PUT update" do
    let(:topic) { FactoryGirl.create(:topic) }
    before { sign_in user }

    context '正常パラメータの場合' do
      before { put :update, {topic: {title: Faker::Lorem.sentence}, id: topic} }

      it { expect(response).to redirect_to topic_path(topic) }
      it { expect(flash[:notice]).to eq I18n.t('topics.notices.updated') }
    end

    context '異常パラメータの場合' do
      before { put :update, {topic: {title: nil}, id: topic} }

      it { expect(response).to render_template(:edit) }
      it { expect(response).to_not redirect_to(topic_path(topic))}
    end
  end

  describe "POST favorite" do
    let(:topic) { FactoryGirl.create(:topic) }
    before { sign_in user }

    context "正常パラメータの場合" do
      before { post :favorite, {id: topic} }

      it "favoriteが呼び出される" do
        expect_any_instance_of(User).to receive(:favorite)

        post :favorite, {id: topic}
      end

      it { expect(response).to redirect_to topic }
    end
  end

  describe "POST unfavorite" do
    let(:topic) { FactoryGirl.create(:topic) }
    before do
      sign_in user
      user.favorite(topic)
    end

    context "正常パラメータの場合" do
      before { post :unfavorite, {id: topic} }

      it "favoriteが呼び出される" do
        expect_any_instance_of(User).to receive(:unfavorite)

        post :unfavorite, {id: topic}
      end

      it { expect(response).to redirect_to topic }
    end
  end
end
