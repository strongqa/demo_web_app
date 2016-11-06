class CreateDemoUserService
  def call
    User.find_or_create_by!(email: FFaker::Internet.free_email, name: FFaker::Internet.user_name) do |user|
      user.password = 'Password1234'
      user.password_confirmation = 'Password1234'
      user.confirm
    end
  end
end
