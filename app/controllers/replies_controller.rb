class RepliesController < ApplicationController
  before_action :set_topic, only: [:edit, :update, :create, :destroy]
  before_action :set_reply, only: [:edit, :update, :destroy]

  def create
    @reply = @topic.replies.build reply_params
    @reply.author = current_user

    respond_to do |format|
      if @reply.save
        @msg = t('replies.notices.created')
        format.html { redirect_to @topic, flash: { reply_notice: @msg } }
        format.js
      else
        format.html { redirect_to @topic }
        format.js { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @reply.update reply_params
      redirect_to @topic, flash: { reply_notice: t('replies.notices.updated') }
    else
      render :edit
    end
  end

  def destroy
    @topic.replies.delete(@reply)
    redirect_to @topic, notice: t('replies.notices.deleted')
  end

  private
    def set_topic
      @topic = Topic.where(id: params[:topic_id]).first
      redirect_to root_path unless @topic
    end

    def set_reply
      @reply = Reply.where(id: params[:id]).first
      redirect_to @topic, alert: t('replies.alerts.not_found') unless @reply
    end

    def reply_params
      params.require(:reply).permit(:body)
    end
end
