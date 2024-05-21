class ArticlesController < ApplicationController
  def index
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else 
      render :new, status: :unprocessable_entity
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end
end
