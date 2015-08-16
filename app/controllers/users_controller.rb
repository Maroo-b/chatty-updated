class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
      @users = User.where.not("id = ?",current_user.id).order("created_at DESC")
      @conversations = Conversation.involving(current_user).order("created_at DESC")
  end

  def setting

    current_user.mute = !current_user.mute if params[:mute]
    current_user.save
    redirect_to root_path
  end
end
