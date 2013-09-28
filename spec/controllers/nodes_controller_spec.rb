require 'spec_helper'

describe NodesController do

  describe "GET 'show'" do
    let(:node) { FactoryGirl.create(:node) }
    before { get :show, id: node }

    it "returns http success" do
      response.should be_success
    end

    it "@nodeは設定される" do
      expect(assigns(:node)).to be_a(Node)
    end

    it "@topicsは設定される" do
      expect(assigns(:topics)).to_not be_nil
    end
  end

end
