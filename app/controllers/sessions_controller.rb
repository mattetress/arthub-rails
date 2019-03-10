class SessionsController < ApplicationController

  def new
    redirect_to current_user if logged_in?
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:error] = "There was a problem logging you in. Please check credentials and try again."
      render :new
    end
  end

  def destroy
    session.delete :user_id
    redirect_to :root
  end

end
