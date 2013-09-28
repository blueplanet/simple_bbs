class TopicsController < ApplicationController
  def index
    @topics = Topic.order(:id).page params[:page]
  end
end
