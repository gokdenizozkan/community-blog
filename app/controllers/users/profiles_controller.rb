class Users::ProfilesController < ApplicationController
  before_action :set_user

  def show
    if user_signed_in?
      @pending_comments = []
      @comments_of_current_user = []

      @profile_user.articles.published.each do |article|
        article.comments.each do |comment|
          @pending_comments << comment if comment.status.to_sym == :pending

          if !(@profile_belongs_to_current_user) && comment.user.id == current_user.to_i
            @comments_of_current_user << comment
          end
        end
      end
    end
  end

  private
  def set_user
    @profile_user = User.find params[:id]
    @profile_belongs_to_current_user = current_user.id == @profile_user&.id.to_i if user_signed_in?
  end
end


# user_is_current_user -> profile_belongs_to_current_user
# user -> profile_user