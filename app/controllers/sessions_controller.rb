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

  def facebook
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.password = SecureRandom.hex(16)
      u.grab_image(auth['info']['image'])
    end

    session[:user_id] = @user.id
    redirect_to @user
  end

  def destroy
    session.delete :user_id
    redirect_to :root
  end

  def return_current_user
    render json: {id: current_user.id}
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
