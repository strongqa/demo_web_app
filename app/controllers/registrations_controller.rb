class RegistrationsController < Devise::RegistrationsController
  before_action :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password avatar password_confirmation])
    devise_parameter_sanitizer.permit(
      :account_update, keys: %i[name email password password_confirmation avatar current_password]
    )
  end
end
