class ApplicationController < ActionController::Base
  def authorize_against_current_user(user_id)
    unless current_user.id == user_id.to_i
      redirect_back fallback_location: root_path
    end
  end
end
