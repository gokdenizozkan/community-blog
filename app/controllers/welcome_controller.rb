class WelcomeController < ApplicationController
	def index
		@articles = Article.all
		@article_count = @articles.length
	end
end
