class PostsController < ApplicationController
  def index
  end
  def new
    @post = Post.new
  end
  def create
  	@post = current_user.content.build(params[:post])
    if @post
      redirect_to user_path(current_user)
  end
  def destroy
  end
  private 
  def post_params
  	params.require(:post).permit(:title, :body, :content)
  end)
end
