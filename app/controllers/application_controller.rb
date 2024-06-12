class ApplicationController < ActionController::Base
  before_action :set_locale

  def authorize_against_current_user(user_id)
    unless current_user.id == user_id.to_i
      redirect_back fallback_location: root_path
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
