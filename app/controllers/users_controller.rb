class UsersController < ApplicationController

  def index
  end

  def new
    @user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      session[:user_id] = @user.id
  		redirect_to user_path @user
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(params[:user]).reverse.first(10)

  def update
  	@user = User.find(params[:id])
  	if @user
  		@user.update(username: params[:username], password: params[:password])
      redirect_to user_path current_user
    end
  end


  def destroy
  	@user = User.find(params[:id])
  	if @user.destroy
  		redirect_to root_path
  	else
  		redirect_to user_path
    end
  end


  private

  def user_params
  	params.require(:user).permit(:username, :password)
  end
end
