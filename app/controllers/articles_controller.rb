class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.published
  end

  def show
    @upvote_count = Vote.where(article: @article, up: true).count
    @downvote_count = Vote.where(article: @article, up: false).count
    @approved_comments = Comment.where article: @article, status: :approved

    if user_signed_in?
      @comments_of_current_user = Comment.where article: @article, user: current_user
    end
  end

  def new
    @article = Article.new
  end 

  def create
    @article = Article.new article_params
    @article.user = current_user

    respond_to do | format |
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article created successfuly." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do | format |
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article updated successfuly." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy!

    respond_to do | format |
      format.html { redirect_to articles_url, notice: "Article deleted successfuly." }
    end
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :published)
  end
end
