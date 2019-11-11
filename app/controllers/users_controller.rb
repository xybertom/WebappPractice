class UsersController < ApplicationController

  before_action :authenticate_user!, :only => [:show, :index, :edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to "/users"
      flash[:alert] = "invaild user"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.id == current_user.id
      @user.update(params.require(:user).permit(:screen_name, :self_introduction))
    else
      redirect_to "/users"
      flash[:alert] = "invaild user"
    end
  end
end