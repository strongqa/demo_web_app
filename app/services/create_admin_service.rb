class CreateAdminService
  def call
    User.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |user|
      user.password = ENV['ADMIN_PASSWORD']
      user.password_confirmation = ENV['ADMIN_PASSWORD']
      user.name = 'Admin User'
      user.confirm
    end
  end
end
