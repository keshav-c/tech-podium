class UsersController < ApplicationController
  before_action :authorize, only: :show

  def show
    @user = current_user
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
      flash.now[:danger] = 'User already in db!' if User.exists?(username: user_params[:username])
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :fullname)
  end
end
