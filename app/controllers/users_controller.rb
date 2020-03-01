class UsersController < ApplicationController
  before_action :authorize, only: :show

  def show
    @user = User.find(params[:id])
    @message = Message.new
    @feed = @user.messages
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

  private

  def user_params
    params.require(:user).permit(:username, :fullname)
  end
end
