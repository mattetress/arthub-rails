class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    user ||= User.find(session[:user_id])
  end

  def login_required
    redirect_to :root unless logged_in?
  end

  def owner_required
    return head(:forbidden) unless current_user == @user
  end
end
