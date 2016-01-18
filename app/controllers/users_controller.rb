class UsersController < ApplicationController

  def index
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.create(user_params)
  	if @user.save
      session[:user_id] = @user.id
  		redirect_to user_path(@user)
    end
  end

  def show
    @user = User.find(params[:id])
    @post = Post.new
    @posts = Post.where(user_id: @user.id).reverse.first(10)
	
  end

  def edit
    @user = current_user
  end


  def update
      @user = current_user
  		@user.update(username: params[:username], password: params[:password], avatar: params[:avatar])
      if @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        flash[:alert] = "sorry you're a fraud"
      end
  end

  def profile
    @user = User.find_by(params[:id])
  end

  def destroy
  	@user = User.find(params[:id])
  	if @user.destroy
  		session.clear
  		redirect_to root_path
  	else
  		redirect_to user_path
    end
  end

  private

  def user_params
  	params.require(:user).permit(:username, :password, :password_confirmation, :email, :avatar)
  end
end
