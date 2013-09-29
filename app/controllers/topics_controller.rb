class TopicsController < ApplicationController
  def index
    @topics = Topic.order(:id).page params[:page]
  end

  def show
    @topic = Topic.find params[:id]
  end
end
