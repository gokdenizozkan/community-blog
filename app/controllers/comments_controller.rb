class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_article, only: [:update, :destroy, :approve, :reject]
	before_action :set_comment, only: [:edit, :update, :destroy]
	before_action -> { authorize_against_current_user @comment.user.id }, only: [:update, :destroy]
	before_action -> { authorize_against_current_user @article.user.id }, only: [:approve, :reject]

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
		respond_to do |format|
			if @comment.update comment_params
				format.html { redirect_to article_url @article, notice: 'Comment has been updated.' }
			else
				format.html { redirect_to article_url @article, alert: 'Comment was not updated.' }
			end
		end
	end

	def destroy
	  @comment.destroy
	  redirect_back fallback_location: root_path
	end

	def approve
		comment = Comment.find comment_approval_params[:comment_id]
		comment.status = :approved
		comment.save!

		redirect_back fallback_location: root_path
	end

	def reject
		comment = Comment.find comment_approval_params[:comment_id]
		comment.status = :rejected
		comment.save!
		
		redirect_back fallback_location: root_path
	end

	private
	def set_article
		@article = Article.find params[:article_id]
	end

	def set_comment
	  @comment = @article.comments.find params[:id]
	end

	def comment_params
	  params.require(:comment).permit(:body)
	end

	def comment_approval_params
		params.require(:comment).permit(:comment_id)
	end
end
