class PostsController < ApplicationController
  def index
  end
  def new
    @post = Post.new
  end
  def create
  	@post = current_user.content.build(params[:post])
  end
  def destroy
  end
  private 
  def post_params
  	params.require (:post).permit(:title, :body
  end)
end
