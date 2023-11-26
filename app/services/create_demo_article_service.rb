class CreateDemoArticleService
  def call
    article = create_article
    [*(0..5)].sample.times do
      user = User.offset(rand(User.count)).first
      article.comments << Comment.create!(article:, body: FFaker::Lorem.sentence, user:)
    end
  end

  private

  def create_article
    article = Article.create!(article_params)
    article.update(created_at: [*(0..5)].sample.days.ago + [*(0..64_000)].sample)
    article
  end

  def article_params
    {
      title: FFaker::HipsterIpsum.sentence,
      text: FFaker::HipsterIpsum.paragraph,
      category: Category.all.sample,
      tags: Tag.all.sample(2),
      user: User.all.sample
    }
  end
end
