class SetLanguageController < ApplicationController
  def english
    I18n.locale = :en
    set_session_and_redirect
  end

  def indonesia
    I18n.locale = :id
    set_session_and_redirect
  end
  
  def change_locale
    session[:language] = params[:locale]
    redirect_to request.env['HTTP_REFERER']
  end
  
  private
  def set_session_and_redirect
    session[:locale] = I18n.locale
    redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to :root
  end
end