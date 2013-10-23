require 'spec_helper'

describe Reply do
  it { should belong_to(:topic) }
  it { should belong_to(:author) }
  it { should validate_presence_of(:body) }

  describe "#after_create" do
    let(:node) { FactoryGirl.create(:node) }
    let(:topic) { FactoryGirl.create(:topic) }

    it "#topic.node.hot 更新される" do
      expect {
        reply = FactoryGirl.create(:reply, topic: topic)
        topic.reload
      }.to change(topic.node, :hot).by(1)
    end
  end
end
