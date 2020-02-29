class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  private

  def current_user
    return nil if cookies.signed[:user_id].nil?

    @current_user ||= User.find_by(id: cookies.signed[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def authorize
    redirect_to login_url if current_user.nil?
  end
end
