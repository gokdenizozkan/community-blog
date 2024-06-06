class Users::ProfilesController < ApplicationController
  def show
    @user = User.find params[:id]
    @user_is_current_user = current_user == @user
  end

  private
  def set_user
    @user = User.find params[:id]
  end
end
