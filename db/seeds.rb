User.destroy_all
Article.destroy_all

user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

5.times { CreateDemoUserService.new.call }
puts 'Created 5 test users'

3.times { CreateDemoArticleService.new.call }
puts 'Created 3 test aticles'
