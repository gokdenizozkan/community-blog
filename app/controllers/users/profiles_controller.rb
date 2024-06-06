class Users::ProfilesController < ApplicationController
  def show
    @user = User.find params[:id]
    @user_is_current_user = current_user == @user

    if user_signed_in?
      @pending_comments = []
      @comments_of_current_user = []

      @user.articles.published.each do |article|
        article.comments.each do |comment|
          @comments_of_current_user << comment if comment.user == current_user
          @pending_comments << comment if comment.status.to_sym == :pending
        end
      end
    end
  end

  private
  def set_user
    @user = User.find params[:id]
  end
end
