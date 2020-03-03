class UsersController < ApplicationController
  before_action :authorize, only: %i[show following followers]

  def show
    @user = User.find(params[:id])
    @message = Message.new
    if @user == current_user
      following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
      @feed = Message.where("user_id IN (#{following_ids}) OR user_id = :user_id",
                            user_id: @user.id)
    else
      @feed = @user.messages
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      cookies.signed[:user_id] = @user.id
      redirect_to @user
    else
      render 'new'
    end
  end

  def following
    @title = "#{current_user.fullname} is following"
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "#{current_user.fullname}'s followers"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:username, :fullname)
  end
end
