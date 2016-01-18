class SessionsController < ApplicationController
  def new
  end
  def create
  	@user = User.authenticate(params[:username], params[:password])
  	if @user
      session[:user_id] = @user.id
  		redirect_to user_path(@user.id)
  	else
  		redirect_to log_in_path
  	end
  end
  def destroy
  	@user = User.where(params[:id]).first 
  	if @user
      session[:user_id] = nil
      flash[:notice] = "you've been logged out successfully!"
      redirect_to log_in_path
    else
      flash[:alert] = "We had a difficult time logging you out"
  	end
  end
end