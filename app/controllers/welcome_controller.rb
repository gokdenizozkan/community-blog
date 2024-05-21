class WelcomeController < ApplicationController
	def index
		@articles = Article.all
		@article_count = @articles.count
	end
end
