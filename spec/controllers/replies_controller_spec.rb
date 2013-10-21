require 'spec_helper'

describe RepliesController do
  let(:topic) { FactoryGirl.create(:topic_with_replies) }
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user}

  describe "POST create" do
    context '正常のパラメータの場合' do
      before { post :create, {topic_id: topic, reply: {body: Faker::Lorem.paragraph}} }

      it { expect(assigns(:topic)).to eq topic }
      it { should redirect_to topic_path(topic) }
      it { expect(flash[:notice]).to eq I18n.t('replies.notices.created') }

      it "書き込みが追加される" do
        expect {
          post :create, {topic_id: topic, reply: {body: Faker::Lorem.paragraph}}
        }.to change(topic.replies, :count).by(1)
      end
    end

    context '異常のパラメータの場合' do
      it "トピックが存在しない場合はトップページにリダイレクト" do
        post :create, {topic_id: "abc", reply: {body: Faker::Lorem.paragraph}}

        expect(response).to redirect_to root_path
      end

      it "書き込み内容が空の場合は、トピックページにリダイレクト" do
        post :create, {topic_id: topic, reply: {body: nil}}

        expect(response).to redirect_to topic
      end
    end
  end

  describe "GET edit" do
    let(:reply) { FactoryGirl.create(:reply, topic: topic) }
    before { get :edit, {topic_id: topic, id: reply }}

    it { expect(response).to be_success }
    it { expect(assigns(:reply)).to eq reply }
  end

  describe "PUT update" do
    let(:reply) { FactoryGirl.create(:reply, topic: topic) }
    let(:new_body) { Faker::Lorem.paragraph }

    context '正常のパラメータの場合' do
      before { put :update, {topic_id: topic, id: reply, reply: {body: new_body} }}

      it { expect(response).to redirect_to topic }
      it { expect(assigns(:reply).id).to eq reply.id }
      it { expect(flash[:notice]).to eq I18n.t('replies.notices.updated') }
    end

    context "異常のパラメータの場合" do
      it "内容が空の場合はトピックページにリダイレクトされる" do
        put :update, {topic_id: topic, id: reply, reply: {body: nil}}

        expect(response).to render_template(:edit)
      end

      it "書き込みIDが見つからない場合はトピックページにリダイレクトされる" do
        put :update, {topic_id: topic, id: "aabbcc", reply: {body: new_body}}

        expect(response).to redirect_to topic
      end
    end
  end
end
