class NodesController < ApplicationController
  def show
    @node = Node.find(params[:id])
    @topics = @node.topics.order(:id).page params[:page]
    @hot_nodes = Node.order("hot DESC").limit(4)
  end
end
