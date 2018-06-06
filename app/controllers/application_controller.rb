class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login, unless: :devise_controller?
  before_action :require_admin, unless: :devise_controller?

  add_breadcrumb 'Home', :root_path

  helper_method :signed_in_as_admin?

  def signed_in_as_admin?
    user_signed_in? && current_user.admin?
  end

  private

  def require_login
    redirect_to root_path unless current_user
  end

  def require_admin
    redirect_to root_path unless signed_in_as_admin?
  end
end
