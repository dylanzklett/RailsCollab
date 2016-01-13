class CommentsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(comment_params[:body])
		@comment.user = current_user
		@comment.save
		redirect_to post_path(@post)
	end
end
