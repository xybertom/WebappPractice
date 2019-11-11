class PostsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @user = User.find(current_user.id)
  end

  def create
    @post = Post.create(params.require(:post).permit(:user_id, :title, :content).merge(user_id: current_user.id))
    @user = User.find(@post.user_id)
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
    else
      redirect_to "/posts"
      flash[:alert] = "invaild user"
    end
  end

  def update
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    if @post.user_id == current_user.id
      @post.update(params.require(:post).permit(:title, :content))
    else
      redirect_to "/posts"
      flash[:alert] = "invaild user"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    if @post.user_id == current_user.id
      @post.destroy
    else
      redirect_to "/posts"
      flash[:alert] = "invaild user"
    end
  end
end
