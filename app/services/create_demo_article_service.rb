class CreateDemoArticleService
  def call
    article = Article.create!(title: Faker::HipsterIpsum.sentence, text: Faker::HipsterIpsum.paragraph)
    article.update_column(:created_at, [*(0..5)].sample.days.ago + [*(0..64000)].sample)
    [*(0..5)].sample.times do
      user = User.offset(rand(User.count)).first
      article.comments << Comment.create!(article: article, body: Faker::Lorem.sentence, user: user)
    end
  end
end
