class UsersController < ApplicationController
  before_action :set_user, only: [:show, :topics, :favorites]

  def show
    @replies = @user.replies.page params[:page]
  end

  def topics
    @topics = @user.topics.page params[:page]
  end

  def favorites
    @favorites = @user.favorites.page params[:page]
  end

  private
    def set_user
      @user = User.where(id: params[:id]).first
      redirect_to root_path unless @user
    end
end
