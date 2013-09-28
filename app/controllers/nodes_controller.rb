class NodesController < ApplicationController
  def show
    @node = Node.find(params[:id])
    @topics = @node.topics.order(:id).page params[:page]
  end
end
