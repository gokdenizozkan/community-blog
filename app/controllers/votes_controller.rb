class VotesController < ApplicationController
	before_action :authenticate_user!
	before_action { authorize_against_current_user vote_params[:user_id] }

	def create
		@vote = Vote.new
		@vote.user = current_user
		@vote.article = Article.find vote_params[:article_id]
		@vote.up = vote_params[:up]
		@vote.save

		redirect_back fallback_location: root_path
	end

	def update
		@vote.up = vote_params[:up]
		@vote.save

		redirect_back fallback_location: root_path
	end

	def add
		@vote = Vote.find_by article: vote_params[:article_id], user: vote_params[:user_id]
		
		if @vote.present?
			update
		else
			create
		end
	end

	private
	def vote_params
    	params.require(:vote).permit(:user_id, :article_id, :up)
  	end
end
