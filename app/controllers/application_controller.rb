class ApplicationController < ActionController::Base

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    user ||= User.find(session[:user_id])
  end

  def login_required
    redirect_to :root unless logged_in?
  end 
end
