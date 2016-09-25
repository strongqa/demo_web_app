class RegistrationsController < Devise::RegistrationsController
  before_action :update_sanitized_params, if: :devise_controller?
  set_tab :register

  def update_sanitized_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(
      :account_update, keys: [:name, :email, :password, :password_confirmation, :current_password]
    )
  end
end
