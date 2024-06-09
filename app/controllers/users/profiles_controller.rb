class Users::ProfilesController < ApplicationController
  before_action :set_user

  def show
    if user_signed_in?
      @pending_comments = []
      @comments_of_current_user = []

      @user.articles.published.each do |article|
        article.comments.each do |comment|
          @pending_comments << comment if comment.status.to_sym == :pending
        end
      end

      @user.comments.each do |comment|
        @comments_of_current_user << comment if comment.user == current_user
      end
    end
  end

  private
  def set_user
    @user = User.find params[:id]
    @user_is_current_user = current_user.id == @user&.id.to_i if user_signed_in?
  end
end
