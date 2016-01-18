class PostsController < ApplicationController

  def index
    @post = Post.find_by(params[:post_id])
    @posts = Post.last(25).reverse
    @comment = @post.comments.build
  end

  def show
    @user = current_user
    if current_user
      @post = Post.find(user_id: @user).post
      @comments = Comment.find_by(user_id: @user).post 
      render action: index
    else
      redirect_to posts_path
    end
  end

  def new
    @post = Post.new
  end

  def create
  	@post = Post.new(post_params)
  		if @post.save
  			redirect_to user_path(current_user)
  		else
  			redirect_to user_path(current_user)
  			flash[:alert] = "Try again, darkness my old friend."
  		end
  end

  def edit
  	@post = Post.find(params[:id])
  	@user = User.find(@post.user_id)
  end
  def update
  	@post = Post.find(params[:id])
  	@user = @post.user
  	@post.update(post_params)
  	@post.save
  	redirect_to user_path(@user)
  end

  def destroy
  	@post = Post.find(params[:id])
		if @post.destroy
		else
			redirect '/edit'
		end
		redirect_to user_path(current_user)
  end

  private 
  def post_params
  	params.require(:post).permit(:title, :content).merge(user_id: current_user.id)
  end
end
