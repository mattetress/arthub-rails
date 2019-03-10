class UsersController < ApplicationController
  before_action :login_required, only: :show

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
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


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio, :website, :avatar)
  end
end
