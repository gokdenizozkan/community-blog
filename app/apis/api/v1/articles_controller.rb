class Api::V1::ArticlesController < ActionController::API
  # GET /articles
  def index
    @articles = Article.published
    render json: @articles
  end

  # GET /articles/1
  def show
    @article = Article.find params[:id]
    render json: @article
  end
end