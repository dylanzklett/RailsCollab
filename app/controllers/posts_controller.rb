class PostsController < ApplicationController
  def index
  end
  def new
    @post = Post.new
  end
  def create
  	@post = current_user.posts.build(post_params)
  		if @post.save
  			redirect_to user_path(current_user)
  		else
  			redirect_to user_path(current_user)
  			flash[:alert] = "Try again, darkness my old friend."
  		end
  end
  def edit
  	@post = Post.find(params[:id])
  	@user = @post.user
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
  	params.require(:post).permit(:title, :content)
  end
end
