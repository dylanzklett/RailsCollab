class CommentsController < ApplicationController
	def new
		@user = current_user
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(comment_params)
	end
	def index
		@user = current_user
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build
	end

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		redirect_to :back
	end

  def comment_params
  	params.require(:comment).permit(:content, :user_id).merge(user_id: current_user.id)
  end
end

