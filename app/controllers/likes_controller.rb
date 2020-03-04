class LikesController < ApplicationController
  before_action :authorize

  def create
    message = Message.find(params[:message_id])
    current_user.like_message(message)
    redirect_back(fallback_location: root_url)
  end

  def destroy
    message = Message.find(params[:message_id])
    like = Like.find(params[:id])
    like.user.undo_like(message)
    redirect_back(fallback_location: root_url)
  end
end
