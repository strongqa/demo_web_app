user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

50.times { CreateDemoUserService.new.call }
puts 'Created 50 test users'

30.times { CreateDemoArticleService.new.call }
puts 'Created 30 test aticles'

