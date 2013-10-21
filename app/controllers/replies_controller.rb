class RepliesController < ApplicationController
  def create
    if @topic = Topic.where(id: params[:topic_id]).first
      if @topic.replies.create params.require(:reply).permit(:body)
        redirect_to @topic, notice: t('replies.notices.created')
      else
        redirect_to @topic
      end
    else
      redirect_to root_path
    end
  end
end
