class UsersController < ApplicationController

  def show
    @user = User.where(id: params[:id]).first
    @topics = @user.topics.page params[:page]
  end
end
