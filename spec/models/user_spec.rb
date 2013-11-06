require 'spec_helper'

describe User do
  it { should have_many(:topics) }
  it { should have_many(:replies) }
  it { should have_and_belong_to_many(:favorites) }

  it { should respond_to :favorite }

  describe "#favorite" do
    let(:user) { FactoryGirl.create(:user) }
    let(:topic) { FactoryGirl.create(:topic) }

    it "お気に入りに追加される" do
      expect {
        user.favorite(topic)
      }.to change(user.favorites, :count).by(1)

      expect(user.favorites).to include(topic)
    end
  end

  describe "#unfavorite" do
    let(:user) { FactoryGirl.create(:user) }
    let(:topic) { FactoryGirl.create(:topic) }
    before { user.favorite(topic) }

    it "お気に入りから削除される" do
      expect {
        user.unfavorite(topic)
      }.to change(user.favorites, :count).by(-1)

      expect(user.favorites).to_not include(topic)
    end
  end
end
