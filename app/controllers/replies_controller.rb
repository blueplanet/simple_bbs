class RepliesController < ApplicationController
  before_action :set_topic, only: [:edit, :update, :create]
  before_action :set_reply, only: [:edit, :update]

  def create
    reply = @topic.replies.build reply_params
    reply.anthor = current_user

    if reply.save
      redirect_to @topic, notice: t('replies.notices.created')
    else
      redirect_to @topic
    end
  end

  def update
    if @reply.update reply_params
      redirect_to @topic, notice: t('replies.notices.updated')
    else
      render :edit
    end
  end

  private
    def set_topic
      @topic = Topic.where(id: params[:topic_id]).first
      redirect_to root_path unless @topic
    end

    def set_reply
      @reply = Reply.where(id: params[:id]).first
      redirect_to @topic unless @reply
    end

    def reply_params
      params.require(:reply).permit(:body)
    end
end
