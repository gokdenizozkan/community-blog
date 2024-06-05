class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_comment, only: [:edit, :update, :destroy]

	def new
	  @comment = Comment.new params[:article_id]
	end 

	def create
	  @comment = Comment.new comment_params
	  @comment.user = current_user
	  @comment.article = Article.find params[:article_id]

	  @comment.save
	  redirect_back fallback_location: root_path
	end

	def edit
	end

	def update
		@comment.update comment_params
		redirect_back fallback_location: root_path
	end

	def destroy
	  @comment.destroy!

	  redirect_back fallback_location: root_path
	end

	private
	def set_comment
	  @comment = Comment.find(params[:id])
	end

	def comment_params
	  params.require(:comment).permit(:body)
	end
end
