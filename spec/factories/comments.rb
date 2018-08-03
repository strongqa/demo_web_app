FactoryBot.define do
  factory :comment do
    user
    article
    sequence(:body) { |b| "Hello, World!-#{b}" }

    before(:create) do |f|
      f.article_id = f.article.try(:id)
      f.user_id = f.user.try(:id)
    end
  end
end
