class CreateAdminService
  def call
    user = User.find_or_create_by!(email: Rails.application.config_for(:admin)['email']) do |user|
      user.password = Rails.application.config_for(:admin)['password']
      user.password_confirmation = Rails.application.config_for(:admin)['password']
      user.name = Rails.application.config_for(:admin)['name']
      user.confirm!
    end
  end
end
