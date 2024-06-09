class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :set_user_is_current_user, only: [:show]
  before_action -> { authorize_against_current_user @article.user.id }, only: [:edit, :update, :destroy]

  def index
    @articles = Article.published
  end

  def show
    unless @article.published
      redirect_to root_path unless @user_is_current_user
    end

    @upvote_count = Vote.where(article: @article, up: true).count
    @downvote_count = Vote.where(article: @article, up: false).count
    @approved_comments = Comment.where article: @article, status: :approved

    set_comments if user_signed_in?
  end

  def new
    @article = Article.new
  end 

  def create
    @article = Article.new(article_params.except(:tags))
    @article.user = current_user
    create_or_delete_articles_tags(@article, params[:article][:tags])

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
    create_or_delete_articles_tags(@article, params[:article][:tags])
    respond_to do | format |
      if @article.update(article_params.except(:tags))
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
    @article = Article.find params[:id]
  end

  def article_params
    params.require(:article).permit(:title, :body, :published, :tags)
  end

  def create_or_delete_articles_tags(article, tags)
    article.taggings.destroy_all
    tags = tags.strip.split ','
    tags.each do |tag|
      article.tags << Tag.find_or_create_by(name: tag)
    end
  end

  def set_user_is_current_user
    if user_signed_in?
      @user_is_current_user = current_user == @article.user
    end
  end

  def set_comments
    @comments_of_current_user = Comment.where article: @article, user: current_user

    if @user_is_current_user
      @pending_comments = Comment.where article: @article, status: :pending
    end
  end
end
