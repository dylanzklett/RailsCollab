class PostsController < ApplicationController
  def index
  end
  def new
  end
  def create
  	@post = current_user.posts.build(params[:post])
  end
  def destroy
  end
  private 
  def post_params
  	params.require (:post).permit(:title, :body
  end)
end
