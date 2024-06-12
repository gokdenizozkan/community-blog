class ApplicationController < ActionController::Base
  around_action :switch_locale

  def authorize_against_current_user(user_id)
    unless current_user.id == user_id.to_i
      redirect_back fallback_location: root_path
    end
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
