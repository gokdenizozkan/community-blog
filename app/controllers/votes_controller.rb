class VotesController < ApplicationController
	before_action :authenticate_user!

	def create
		@vote = Vote.new
		@vote.user = current_user
		@vote.article = Article.find vote_params[:article]
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
		@vote = Vote.find_by article: vote_params[:article], user: vote_params[:user]
		
		if @vote.present?
			update
		else
			create
		end
	end
	    

	private
	def vote_params
    	params.require(:vote).permit(:user, :article, :up)
  	end
end
