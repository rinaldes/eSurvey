class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :set_locale

  def authenticate_admin
    unless current_user.role == "admin"
      redirect_to root_path, :notice => "Authenticated admin needed here!"
    end
  end

  def set_locale
    session[:language] = 'en' unless session[:language]
    I18n.locale = session[:language]
    Rails.application.routes.default_url_options[:locale]= I18n.locale
  end
end
