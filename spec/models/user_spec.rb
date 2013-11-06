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

      expect(user.favorites.first).to eq topic
    end
  end
end
