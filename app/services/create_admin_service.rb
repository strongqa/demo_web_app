class CreateAdminService
  def call
    User.find_or_create_by!(email: ENV.fetch('ADMIN_EMAIL')) do |user|
      user.password = ENV.fetch('ADMIN_PASSWORD')
      user.password_confirmation = ENV['ADMIN_PASSWORD']
      user.name = 'Admin User'
      user.is_admin = true
      user.confirm
    end
  end
end
