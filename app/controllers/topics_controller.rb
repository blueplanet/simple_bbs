class TopicsController < ApplicationController
  def index
    @topics = Topic.order("replies_count DESC").page params[:page]
  end

  def show
    @topic = Topic.find params[:id]
    @last_reply = @topic.replies.last
  end

  def new
    @topic = Topic.new
    @nodes = Node.all
  end

  def create
    @topic = Topic.new post_params.merge(author: current_user)
    if @topic.save
      redirect_to @topic, notice: t('topics.created')
    else
      render :new
    end
  end

  private
    def post_params
      params.require(:topic).permit(:node_id, :title, :body)
    end
end
