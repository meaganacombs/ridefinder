class UsersController < ApplicationController
  # The User Controller deals with users creating profiles, editing profiles, and deleting them. To update, edit,
  # and destroy a profile, the user must be logged in, and the profile that is being changed must be that users'.
  
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy ]
  def new
    @user = User.new
  end
  
  
  def create
    @user = User.new(user_params)
    if @user.save
       log_in @user
      redirect_to '/drives'
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "your profile has been updated"
      redirect_to '/drives'
    else
      render 'edit'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @drives = Drive.all
    @id = "," + @user.id.to_s + ","
  end
  
  def destroy
    User.find(params[:id]).destroy 
    flash[:success] = "your account was deleted"
    redirect_to '/signup'
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
  
  def logged_in_user
    unless logged_in?
      flash[:danger] = "please log in!"
      redirect_to login_url
      end
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
end
