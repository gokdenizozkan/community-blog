class ArticlesController < ApplicationController
  def index
  end

  def new
    @article = Article.new
  end 

  def create
    @article = Article.new(article_params)
    @article.status = "DRAFT"

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
