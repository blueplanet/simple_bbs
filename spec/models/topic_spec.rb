require 'spec_helper'

describe Topic do
  it { should belong_to :node }
  it { should belong_to :author }
  it { should have_many :replies }

  describe "#replies_count" do
    let(:topic) { FactoryGirl.create(:topic) }

    it "reply作成するとCountが＋１" do
      expect {
        topic.replies.create FactoryGirl.attributes_for(:reply)
        topic.reload
      }.to change(topic, :replies_count).by(1)
    end
  end
end
