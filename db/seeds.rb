Tag.destroy_all
Article.destroy_all
Category.destroy_all
User.destroy_all

user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

5.times { CreateDemoUserService.new.call }
puts 'Created 5 test users'

3.times { CreateCategoryService.new.call }
puts 'Created 3 test categories'

3.times { CreateTagService.new.call }
puts 'Created 3 test tags'

3.times { CreateDemoArticleService.new.call }
puts 'Created 3 test aticles'
