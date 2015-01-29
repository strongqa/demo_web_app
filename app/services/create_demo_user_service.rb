class CreateDemoUserService
  def call
    user = User.find_or_create_by!(email: Faker::Internet.free_email, name: Faker::Internet.user_name) do |user|
      user.password = 'Password1234'
      user.password_confirmation = 'Password1234'
      user.confirm!
    end
  end
end