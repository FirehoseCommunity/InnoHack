class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def render_not_found(status=:not_found)
    render text: "#{status.to_s.titleize} :(", status: status
  end

  def access_denied
    redirect_to root_path
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)  << :name
    devise_parameter_sanitizer.for(:sign_up)  << :GitHub
  end

end
