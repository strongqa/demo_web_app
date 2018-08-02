FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "tag-#{n}-" }
    trait :with_articles do
      after(:create) do |f|
        f.articles = create_list(:article, 2)
        f.save!
      end
    end
  end
end
