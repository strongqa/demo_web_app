class CreateDemoArticleService
  def call
    article = create_article
    [*(0..5)].sample.times do
      user = User.offset(rand(User.count)).first
      article.comments << Comment.create!(article: article, body: FFaker::Lorem.sentence, user: user)
    end
  end

  private

  def create_article
    article = Article.create!(title: FFaker::HipsterIpsum.sentence,
      text: FFaker::HipsterIpsum.paragraph,
      category: Category.all.sample,
      tags: Tag.all.sample(2)
    )
    article.update_column(:created_at, [*(0..5)].sample.days.ago + [*(0..64_000)].sample)
    article
  end
end
