require 'spec_helper'

describe TopicsController do
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "@topicsが設定さている" do
      get 'index'
      expect(assigns(:topics)).to_not be_nil
    end
  end
end
