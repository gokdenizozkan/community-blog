class Users::ProfilesController < ApplicationController
  before_action :set_user
  before_action :user_params, only: [:update_nickname]

  def show
    if user_signed_in?
      @pending_comments = []
      @comments_of_current_user = []

      @profile_user.articles.published.each do |article|
        article.comments.each do |comment|
          @pending_comments << comment if comment.status.to_sym == :pending

          if !(@profile_belongs_to_current_user) && comment.user.id == current_user.id.to_i
            @comments_of_current_user << comment
          end
        end
      end
    end
  end

  def edit_nickname
  end

  def update_nickname
    redirect_to root_path unless @profile_belongs_to_current_user
    
    if @profile_user.nickname == user_params[:nickname] || @profile_user.update(user_params)
      redirect_to user_profile_path(@profile_user), notice: I18n.t('shared.messages.successfuly.updated', resource: I18n.t('activerecord.attributes.article.nickname'))
    else
      render :edit_nickname, status: :unprocessable_entity
    end
  end

  private
  def set_user
    @profile_user = User.find params[:id]
    @profile_belongs_to_current_user = user_signed_in? && current_user.id == @profile_user&.id.to_i
  end

  def user_params
    params.require(:user).permit(:nickname)
  end
end