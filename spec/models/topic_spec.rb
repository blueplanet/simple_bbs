require 'spec_helper'

describe Topic do
  it { should belong_to :node }
  it { should belong_to :author }
  it { should have_many :replies }
  it { should belong_to :last_reply }

  it { should validate_presence_of(:node_id) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

  describe "#replies_count" do
    let(:topic) { FactoryGirl.create(:topic) }

    it "reply作成するとCountが＋１" do
      expect {
        topic.replies.create FactoryGirl.attributes_for(:reply)
        topic.reload
      }.to change(topic, :replies_count).by(1)
    end
  end

  describe "#last_reply" do
    let(:topic) { FactoryGirl.create(:topic) }

    it "reply作成すると last_reply が更新される" do
      expect {
        topic.replies.create FactoryGirl.attributes_for(:reply)
        topic.reload
      }.to change(topic, :last_reply)

      expect(topic.last_reply).to eq topic.replies.last
    end
  end
end
