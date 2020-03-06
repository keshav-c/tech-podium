class UsersController < ApplicationController
  before_action :authorize, only: %i[show following followers]

  def show
    @user = !params[:id].nil? ? User.find(params[:id]) : current_user
    @feed = if @user == current_user
              Message.feed(@user, current_user: @user)
            else
              Message.feed(@user, current_user: current_user)
            end
    @logged_in_user = @user == current_user
    @users_list = if @logged_in_user
                    @user.users_to_follow
                  else
                    @user.followers
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
    @user = User.find(params[:id])
    @title = "#{@user.fullname} is following"
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @title = "#{@user.fullname}'s followers"
    @users = @user.followers
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:username, :fullname, :photo, :coverimage)
  end
end
