require 'spec_helper'

describe RepliesController do
  let(:topic) { FactoryGirl.create(:topic) }
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
end
