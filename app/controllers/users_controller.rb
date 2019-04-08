class UsersController < ApplicationController
  before_action :login_required, except: [:new, :create]
  before_action :set_user, except: [:new, :create, :dashboard]


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
  end

  def edit
    owner_required
  end

  def update
    owner_required
    if @user.update(user_params)
      flash[:success] = "Your profile has been updated."
      redirect_to @user
    else
      render 'users/edit'
    end
  end

  def change_avatar
    owner_required
  end

  def update_avatar
    owner_required

    @user.avatar.purge

    @user.update(user_params)
    redirect_to @user
  end

  def new_resume
  end

  def attach_resume
    owner_required

    @user.resume.purge

    @user.update(user_params)
    redirect_to @user
  end

  def dashboard
    @events = current_user.upcoming_events
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio, :website, :avatar, :resume)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
