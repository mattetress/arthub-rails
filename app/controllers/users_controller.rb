class UsersController < ApplicationController
  before_action :login_required, only: :show

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      render 'users/welcome'
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    owner_required
  end

  def update
    @user = User.find(params[:id])
    owner_required
    if @user.update(user_params)
      flash[:success] = "Your profile has been updated."
      redirect_to @user
    else
      render 'users/edit'
    end
  end

  def change_avatar
    @user = User.find(params[:id])
    owner_required
  end

  def update_avatar
    @user = User.find(params[:id])
    owner_required

    @user.avatar.purge

    @user.update(user_params)
    redirect_to @user
  end

  def new_resume
    @user = User.find(params[:id])
  end

  def attach_resume
    @user = User.find(params[:id])
    owner_required

    @user.resume.purge

    @user.update(user_params)
    redirect_to @user
  end 

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio, :website, :avatar, :resume)
  end
end
