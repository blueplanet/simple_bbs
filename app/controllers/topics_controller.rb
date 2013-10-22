class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_topic, only: [:show, :edit, :update]
  before_action :set_nodes, only: [:new, :edit]

  def index
    @topics = Topic.order("replies_count DESC").page params[:page]
  end

  def show
    @last_reply = @topic.replies.last
    @replies = @topic.replies.page params[:page]
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new post_params.merge(author: current_user)
    if @topic.save
      redirect_to @topic, notice: t('topics.notices.created')
    else
      render :new
    end
  end

  def update
    if @topic.update post_params
      redirect_to @topic, notice: t('topics.notices.updated')
    else
      render :edit
    end
  end

  private
    def set_topic
      @topic = Topic.find params[:id]
    end

    def set_nodes
      @nodes = Node.all
    end

    def post_params
      params.require(:topic).permit(:node_id, :title, :body)
    end
end
