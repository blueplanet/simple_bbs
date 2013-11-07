class TopicsController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!, except: [:show, :index, :favorites]
  before_action :set_topic, only: [:show, :edit, :update, :favorite, :unfavorite]
  before_action :set_nodes, only: [:new, :edit, :create]
  before_action :set_hot_nodes, only: [:index, :favorites]

  def index
    @topics = Topic.all.includes(:node, :author, :last_reply).page params[:page]
  end

  def favorites
    @topics = Topic.favs.includes(:node, :author, :last_reply).page params[:page]
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

  def preview
    @body = params[:body]

    render json: { body_html: markdown(@body) }
  end

  def favorite
    current_user.favorite(@topic)
    redirect_to @topic
  end

  def unfavorite
    current_user.unfavorite(@topic)
    redirect_to @topic
  end

  private
    def set_topic
      @topic = Topic.find params[:id]
    end

    def set_nodes
      @nodes = Node.all
    end

    def set_hot_nodes
      @hot_nodes = Node.hot.limit(4)
    end

    def post_params
      params.require(:topic).permit(:node_id, :title, :body)
    end
end
